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
    @State private var image: UIImage? = nil
    var size: CGFloat = 400
    
    var body: some View {
        ScrollView {
            //Picker
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
                            image = UIImage(data: data)
                        }
                    }
                }
            
            //Images
            Text("image:")
            imageView()
            
            Text("mask:")
            maskView()
            
            Text("masked image:")
            maskedImage()
            
            Text("effect:")
            effect()
            
        }
    }
    
    @ViewBuilder func imageView() -> some View{
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: size)
                .border(Color.blue)
        }
    }
    @ViewBuilder func maskView() -> some View{
        if let image, let mask = getMaskFrom(image){
            Image(uiImage: mask)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: size)
                .border(Color.black)
        }
    }
    
    @ViewBuilder func maskedImage() -> some View{
        imageView()
            .mask{
                maskView()
                    .luminanceToAlpha()
            }
    }
    
    @ViewBuilder func effect() -> some View{
        ZStack{
            testColours[0]
            
            imageView()
                .blendMode(.overlay)
            
            maskedImage()
        }

    }
    
    @ViewBuilder func colorEffect() -> some View{
        ZStack{
            imageView()
                
            Rectangle()
                .foregroundColor(testColours[0])
                .blendMode(.color)
            
            maskedImage()
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








struct ImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSegmentationTestView()
    }
}
