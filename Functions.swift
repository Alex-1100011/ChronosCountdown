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

//MARK: + and - for Color

///The + operator to make a ``Color`` **lighter** by  a ``Double`` amount
func +(left: Color, right: Double) -> Color? {
    if let components = left.cgColor?.components, components.count >= 3 {
        
        ///Adding the ``Double`` amount to each rgb component in a range btw 0...1
        let r = max(0, min(1,Double(components[0]) + right))
        let g = max(0, min(1,Double(components[1]) + right))
        let b = max(0, min(1,Double(components[2]) + right))
        
        return Color(red: r, green: g, blue: b)
    }
    return nil
}

///The - operator to make a ``Color`` **darker** by  a ``Double`` amount
func -(left: Color, right: Double) -> Color? {
    return left + (-1*right)
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
