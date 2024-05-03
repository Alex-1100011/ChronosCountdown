//
//  CirclePickerElementView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

///A basic circular view used throughout all the app, it can display an `SFSymbol` with a specific `Color` or `Material` and and Image as a background.
///
///To change the circle color use the `.tint` modifier.
///An outer ring is shown when selected.
struct CircleElementView<S: ShapeStyle>: View {
    var isSelected: Bool = false
    ///The foreground symbol
    var symbolName: String?
    ///This variable conforms to the ShapeStyle, so it could be assigned with any color or material
    var symbolColor: S
    var bgImage: UIImage?
    
    @ScaledMetric var circleSize: CGFloat = 42
    var symbolSize: CGFloat {
        circleSize/2.5
    }
    var selectionRingSize: CGFloat {
        circleSize + (circleSize/4)
    }
    
    
    var body: some View{
   
            ZStack {
                
                //MARK: Image
                if let bgImage = bgImage {
                    Image(uiImage: bgImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: circleSize, height: circleSize)
                        .clipShape(Circle())
                } else {
                    //MARK: Circle
                    Circle()
                        .frame(height: circleSize)
                        .foregroundStyle(.tint)
                }
                
                //MARK: Symbol
                if let symbol = symbolName{
                    Image(systemName: symbol)
                        .foregroundStyle(symbolColor)
                        .font(.system(size: symbolSize, weight: .bold))
                        .symbolVariant(.fill)
                        

                }
                //MARK: Selection ring
                if isSelected{
                    Circle()
                        .stroke(lineWidth: circleSize/15)
                        .frame(width: selectionRingSize, height: selectionRingSize)
                        .foregroundStyle(.tint)
                        .opacity(0.5)
                        //To eliminate the extra frame size due to the ring
                        .padding(-10)
                }
            }
    }
}

///The ``CircleElementView`` as a button with an ``CircleElementButton/action`` to be executed when tapped
struct CircleElementButton<S: ShapeStyle>: View {
    var color: Color
    var isSelected: Bool = false
    var symbolName: String?
    var symbolColor: S
    var bgImage: UIImage?
    
    var action: ()->Void
    
    var body: some View{
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }){
            CircleElementView(
                isSelected: isSelected,
                symbolName: symbolName,
                symbolColor: symbolColor,
                bgImage: bgImage)
            .tint(color)
        }
        .buttonStyle(.plain)
        .hoverEffect(.lift)
    }
}

struct CirclePickerElementView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleElementView(isSelected: true, symbolName: "hourglass", symbolColor: .white)
                .previewDisplayName("symbol selected")
            
            
            CircleElementView(symbolName: "photo", symbolColor: .secondary)
                .previewDisplayName("image")
            
            CircleElementView(isSelected: true, symbolName: "photo", symbolColor: .regularMaterial, bgImage: UIImage(named: "sperlonga"))
                .previewDisplayName("image selected")
            
            CircleElementView(symbolName: "magnifyingglass", symbolColor: .secondary)
                .previewDisplayName("search button")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
            
    }
}
