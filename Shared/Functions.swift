//
//  Functions.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 04/09/22.
//

import SwiftUI

//MARK: if Modifier
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

//MARK: Color to String
extension Color {
    ///Generates a `Color` from a hex `String`
    ///
    ///Used to **retrive** colours from `CoreData`
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


//MARK: String to Color
extension String {
    ///Generates a hex `String` from a `Color`
    ///
    ///Used to **store** colours into `CoreData`
    init(_ color: Color){
        //Get rgb components
        if let components = color.cgColor?.components, components.count >= 3 {
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            //Generate the hex string
            self.init(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        } else {
            self.init("")
        }
    }
}

#if canImport(CoreImage)
//MARK: Color from Image
/// Get the average Color of an Image
///
/// Used to get the counter color from the image selection in the ``BackgroundPicker``
/// - Parameter image: A `UIImage` where to extract the color
/// - Returns: The average `Color` of an Image
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
#endif

extension String {
    ///Capitalises the first letter of a `String`
    ///
    ///Used to display the symbols names in the ``SymbolsListView``
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}



//MARK: Sample Data
var testColours: [Color] = [
    Color(hex: "027AFF"), Color(hex: "1DB2DF"), Color(hex: "44D7B6"),
    Color(hex: "35C759"), Color(hex: "FFCC02"), Color(hex: "FFA700"), Color(hex: "A736FF"), Color(hex: "E020B8"),
    Color(hex: "E02020"), Color(hex: "FF7100")]

var testCounters: [Counter] = [
    Counter(name: "Hello World", date: Date() + 60 * 60 * 24 * 3, color: testColours[3], symbolName: "globe"),
    Counter(name: "Testing", date: Date() + 60 * 60 * 24 * 9, color: testColours[0], symbolName: "hammer"),
    Counter(name: "Coding", date: Date() + 60 * 60 * 24 * 6, color: testColours[4], symbolName: "keyboard")
]


