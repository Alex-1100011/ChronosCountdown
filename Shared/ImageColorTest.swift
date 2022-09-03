//
//  ImageColorTest.swift
//  Chronos Countdown (iOS)
//
//  Created by Alessandro Alberti on 03/09/22.
//

import SwiftUI

struct ImageColorTest: View {
    var imageName: String
    var body: some View {
        ZStack {
            getColorFrom(image: imageName)!
                .ignoresSafeArea()
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            .frame(height: 200)
        }
            
    }
}


func getColorFrom(image: String) -> Color? {
    guard let uiImage = UIImage(named: image)
        else { return nil }
    
    guard let ciImage = CIImage(image: uiImage)
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
        ImageColorTest(imageName: "sperlonga")
            .previewDisplayName("sperlonga")
        ImageColorTest(imageName: "procida")
            .previewDisplayName("procida")
        ImageColorTest(imageName: "giardino")
            .previewDisplayName("giardino")
    }
}
