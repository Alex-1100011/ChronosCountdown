//
//  SymbolPicker.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 02/09/22.
//

import SwiftUI

struct SymbolPicker: View {
    var color: Color = .blue
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))], spacing: 20){
            
            CircleElementView(color: Color(UIColor.tertiarySystemGroupedBackground), symbolName: "magnifyingglass", symbolColor: .secondary)
            
            ForEach(0 ..< 17) { item in
                CircleElementView(color: color, selected: false, symbolName: "airplane", symbolColor: .white)
            }
        }
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
