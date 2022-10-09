//
//  SymbolPicker.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 02/09/22.
//

import SwiftUI

struct SymbolPicker: View {
    var color: Color = .blue
    @Binding var selectedSymbol: String
    @Binding var showSearch: Bool
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))], spacing: 15){
            
            CircleElementButton(color: Color(UIColor.tertiarySystemGroupedBackground), symbolName: "magnifyingglass", symbolColor: .secondary)
            {
                //Display search
                showSearch = true
            }
            
            ForEach(0..<17) { i in
                let symbol = symbols[i].name
                CircleElementButton(color: color, isSelected: selectedSymbol == symbol, symbolName: symbol, symbolColor: .white)
                {
                    selectedSymbol = symbol
                }
            }
        }
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(selectedSymbol: .constant("hourglass"), showSearch: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
