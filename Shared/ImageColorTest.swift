//
//  ImageColorTest.swift
//  Chronos Countdown (iOS)
//
//  Created by Alessandro Alberti on 03/09/22.
//

import SwiftUI
import PhotosUI

struct ImageColorTest: View {
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var image: UIImage?
    
    var body: some View {
        ZStack{
            //Background
            getColorFrom(image: image)
                .ignoresSafeArea()
            
            //Picker
            PhotosPicker(
                selection: $selectedPhotoItem,
                matching: .images,
                photoLibrary: .shared()) {
                    
                    //Image
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .frame(width: 300, height: 300)
                            
                         //Placeholder Image
                    } else {
                        Image(systemName: "photo.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.gray, .thinMaterial)
                    }
    
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
        }
    }
}



func getColorFrom(image: UIImage?) -> Color? {
    guard let image = image
        else { return nil }
    
    guard let ciImage = CIImage(image: image)
        else { return nil }
    
    let extentVector = CIVector(
        x: ciImage.extent.origin.x,
        y: ciImage.extent.origin.y,
        z: ciImage.extent.size.width,
        w: ciImage.extent.size.height)
    
    guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: ciImage, kCIInputExtentKey: extentVector])
        else { return nil }
    
    guard let outputImage = filter.outputImage
    else { return nil }
    
    var bitmap = [UInt8](repeating: 0, count: 4)
    let context = CIContext(options: [.workingColorSpace: kCFNull])
    context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
    
    return Color(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255)
}



struct ImageColorTest_Previews: PreviewProvider {
    static var previews: some View {
        ImageColorTest()
    }
}
