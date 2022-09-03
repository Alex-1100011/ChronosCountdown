//
//  BackgroundPicker.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI


struct BackgroundPicker: View {
    @Binding var color: Color
    
//    @Binding var image
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))], spacing: 15){
            
            //MARK: Colors
            ForEach(colours, id: \.self) { elementColor in
                
                CircleElementView(color: elementColor, isSelected: elementColor == color, symbolColor: .white)
                {
                    color = elementColor
                }
                
            }
            
            //MARK: Multicolor
            CircleElementView(color: color, isSelected: false, symbolColor: .thinMaterial, bgImage: "multicolor")
            {
                //Display color picker
            }
            
            //MARK: Image
            CircleElementView(color: Color(UIColor.tertiarySystemGroupedBackground), isSelected: false, symbolName: "photo", symbolColor: .secondary, bgImage: false ? "sperlonga" : nil)
            {
                //Display image picker
            }
        }
    }
    
    var colours: [Color] = [
        Color(hex: "027AFF"), Color(hex: "1DB2DF"), Color(hex: "44D7B6"),
        Color(hex: "35C759"), Color(hex: "FFCC02"), Color(hex: "FFA700"), Color(hex: "A736FF"), Color(hex: "E020B8"),
        Color(hex: "E02020"), Color(hex: "FF7100")]
    
    
}


extension Color {
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


struct BackgroundPicker_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundPicker(color: .constant(.blue))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


