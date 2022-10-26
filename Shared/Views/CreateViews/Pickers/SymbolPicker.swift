//
//  SymbolPicker.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 02/09/22.
//

import SwiftUI

///This `View` lets the user select a symbol, passed with the binding variable ``SymbolPicker/selectedSymbol``
struct SymbolPicker: View {
    ///The accent color of the elements
    var color: Color = .blue
    ///The symbol selected by the user
    @Binding var selectedSymbol: String
    ///When the search button is tapped this variable turns to `true` and the ``SymbolsView`` should be displayed by the `parent view`
    @Binding var showSearch: Bool
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))], spacing: 15){
            
            CircleElementButton(color: Color(UIColor.tertiarySystemGroupedBackground), symbolName: "magnifyingglass", symbolColor: .secondary)
            {
                //Display search
                showSearch = true
            }
            
            ForEach(0..<17) { i in
                let symbol = symbols[i].symbolName
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
