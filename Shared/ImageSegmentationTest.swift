//
//  ImageTestView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 13/10/22.
//

import SwiftUI
import PhotosUI
import Vision

struct ImageSegmentationTestView: View {
    @State private var selectedPhotoItem: PhotosPickerItem? = nil

    
    @State var bgImage = BackgroundImage(colorEffect: .blue)
    @State var lastScaleValue: CGFloat = 1.0
    
    var size: CGFloat = 400
    
    var body: some View {
        VStack {
            
            
            //Pickers
            HStack {
                PhotosPicker(
                    selection: $selectedPhotoItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        
                        Label("Select an image", systemImage: "photo.fill")
                        
                    }
                //Update image from picker's selection
                    .onChange(of: selectedPhotoItem) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                
                                bgImage.image = UIImage(data: data)
                                bgImage.offset = CGSize.zero
                                
                                
                            }
                        }
                }
                ColorPicker("", selection: $bgImage.colorEffect)
            }
            
            
            //Counter
            ZStack {
                
               CounterCardView(counter:
                                Counter(name: "Presentation", date: Date() + 24 * 24 * 60 * 60, color: testColours[0], symbolName: "car", image: nil, referenceDate: Date()),
                               isSmall: false,
                               bgImage: bgImage)
                    .frame(width: 360, height: 180)
                
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        bgImage.offset = gesture.translation
                    }
            )
            
            .gesture(MagnificationGesture().onChanged { val in
                        let delta = val / self.lastScaleValue
                        self.lastScaleValue = val
                        let newScale = bgImage.scale * delta
                        bgImage.scale = newScale

            //... anything else e.g. clamping the newScale
            }.onEnded { val in
              // without this the next gesture will be broken
              self.lastScaleValue = 1.0
            })
        }
    }
}




func getMaskFrom(_ uiImage: UIImage) -> UIImage?{
    //SegmentationRequest
    let request = VNGeneratePersonSegmentationRequest()
    request.qualityLevel = .accurate
    request.outputPixelFormat = kCVPixelFormatType_OneComponent8

    let handler = VNImageRequestHandler(cgImage: uiImage.cgImage!, options: [:])
    
    do {
        //Perform request
        try handler.perform([request])
        
        let maskBuffer = request.results!.first!.pixelBuffer
        let mask = CIImage(cvPixelBuffer: maskBuffer)
        let input = CIImage(cgImage: uiImage.cgImage!)
        
        //Resize the mask
        let maskScaleX = input.extent.width / mask.extent.width
        let maskScaleY = input.extent.height / mask.extent.height
        
        let maskScaled =  mask.transformed(by: __CGAffineTransformMake(maskScaleX, 0, 0, maskScaleY, 0, 0))
        
        //Create the CGImage and return a UIImage
        let ciContext = CIContext(options: nil)
        let maskImage = ciContext.createCGImage(maskScaled, from: maskScaled.extent)
        
        return UIImage(cgImage: maskImage!)
        
    } catch {
        print(error)
    }
    
    return nil
    
}


struct BackgroundImage{
    var image: UIImage?
    var mask: UIImage? {
        if let image{
            return getMaskFrom(image)
        }
        return nil
    }
    var colorEffect: Color
    var offset = CGSize.zero
    var scale: CGFloat = 1.0
    
    @ViewBuilder func imageView() -> some View{
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .frame(height: size)
        }
    }
    @ViewBuilder func maskView() -> some View{
        if let mask {
            Image(uiImage: mask)
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .frame(height: size)
        }
    }
    
    @ViewBuilder func maskedImage() -> some View{
        imageView()
            .mask{
                maskView()
                    .luminanceToAlpha()
            }
    }
    
}





struct ImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSegmentationTestView()
    }
}
