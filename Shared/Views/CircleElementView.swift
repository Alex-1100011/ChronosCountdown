//
//  CirclePickerElementView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

struct CircleElementView<S: ShapeStyle>: View {
    var color: Color
    var selected: Bool = false
    var symbolName: String?
    ///This variable conforms to the ShapeStyle, so it could be assigned with any color or material
    var symbolColor: S
    var bgImage: String?
    
    var body: some View{
        ZStack {
            //MARK: Circle
            Circle()
                .frame(height: 45)
                .foregroundColor(color)
            
            //MARK: Image
            if let bgImage = bgImage {
                Image(bgImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
            
            //MARK: Symbol
            if let symbol = symbolName{
                Image(systemName: symbol)
                    .foregroundStyle(symbolColor)
                    .font(.system(size: 20, weight: .bold))
                    

            }
            //MARK: Selection ring
            if selected{
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

struct CirclePickerElementView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleElementView(color: .blue, selected: true, symbolName: "hourglass", symbolColor: .white)
                .previewDisplayName("symbol selected")
            
            
            CircleElementView(color: Color(UIColor.tertiarySystemGroupedBackground),symbolName: "photo", symbolColor: .secondary)
                .previewDisplayName("image")
            
            CircleElementView(color: Color(UIColor.tertiarySystemGroupedBackground), selected: true, symbolName: "photo", symbolColor: .regularMaterial, bgImage: "sperlonga")
                .previewDisplayName("image selected")
            
            CircleElementView(color: Color(UIColor.tertiarySystemGroupedBackground), symbolName: "magnifyingglass", symbolColor: .secondary)
                .previewDisplayName("search button")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
            
    }
}
