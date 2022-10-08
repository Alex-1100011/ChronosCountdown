//
//  CirclePickerElementView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

struct CircleElementView<S: ShapeStyle>: View {
    var isSelected: Bool = false
    var symbolName: String?
    ///This variable conforms to the ShapeStyle, so it could be assigned with any color or material
    var symbolColor: S
    var bgImage: UIImage?
  
    
    var body: some View{
   
            ZStack {
                
                //MARK: Image
                if let bgImage = bgImage {
                    Image(uiImage: bgImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                } else {
                    //MARK: Circle
                    Circle()
                        .frame(height: 45)
                        .foregroundStyle(.tint)
                }
                
                //MARK: Symbol
                if let symbol = symbolName{
                    Image(systemName: symbol)
                        .foregroundStyle(symbolColor)
                        .font(.system(size: 20, weight: .bold))
                        .symbolVariant(.fill)
                        

                }
                //MARK: Selection ring
                if isSelected{
                    Circle()
                        .stroke(lineWidth: 3)
                        .frame(width: 55, height: 55)
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        //To eliminate the extra frame size due to the ring
                        .padding(-10)
                }
            }
        
    }
}

struct CircleElementButton<S: ShapeStyle>: View {
    var color: Color
    var isSelected: Bool = false
    var symbolName: String?
    var symbolColor: S
    var bgImage: UIImage?
    
    var action: ()->Void
    
    var body: some View{
        Button(action: action){
            CircleElementView(
                isSelected: isSelected,
                symbolName: symbolName,
                symbolColor: symbolColor,
                bgImage: bgImage)
            .tint(color)
        }
        .buttonStyle(.plain)
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
