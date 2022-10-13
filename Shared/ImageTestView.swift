//
//  ImageTestView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 13/10/22.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageSegmentationTestView: View {
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var image: UIImage? = nil
    
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
            
            if let image {
                Text("image:")
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500, height: 500)
                    .border(Color.blue)
                
                if let mask = segment(image){
                    Text("mask:")
                    Image(uiImage: mask)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 500)
                        .border(Color.blue)
                    
                    Text("masked image:")
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 500)
                        .border(Color.blue)
                        .mask{
                            if let mask = segment(image){
    
                                Image(uiImage: mask)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 500, height: 500)
                                    .luminanceToAlpha()
                                    .border(Color.blue)
                            }
                        }
                }
            }
        }
    }
}


func segment(_ uiImage: UIImage) -> UIImage?{
    if let input = CIImage(image: uiImage){
        //Apply the segmentation filter
        let segmentationFilter = CIFilter.personSegmentation()
        segmentationFilter.inputImage = input

        //Resize the mask
        if let maskImage = segmentationFilter.outputImage{

              let ciContext = CIContext(options: nil)

              let maskScaleX = input.extent.width / maskImage.extent.width
              let maskScaleY = input.extent.height / maskImage.extent.height

              let maskScaled =  maskImage.transformed(by: __CGAffineTransformMake(maskScaleX, 0, 0, maskScaleY, 0, 0))

              let maskRef = ciContext.createCGImage(maskScaled, from: maskScaled.extent)
              return UIImage(cgImage: maskRef!)

          }
        
        return nil
    }

    return nil
    
}








struct ImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSegmentationTestView()
    }
}
