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
        
        TabView {
            ForEach(symbolsCategory.allCases, id: \.self) { category in
                
                ScrollView {
                    SymbolGrid(color: color, selectedSymbol: $selectedSymbol, showSearch: $showSearch, category: category)
                }
                .tabItem({Label(category.name, systemImage: category.symbol)})
                
            }
        }
        .frame(height: 300)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct SymbolGrid: View {
    var color: Color
    @Binding var selectedSymbol: String
    @Binding var showSearch: Bool
    var category: symbolsCategory
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))], spacing: 15){
            
            //Show the search for the first page
            if category == symbolsCategory.allCases[0] {
                CircleElementButton(color: Color(UIColor.tertiarySystemGroupedBackground), symbolName: "magnifyingglass", symbolColor: .secondary)
                {
                    //Display search
                    showSearch = true
                }
            }
            
            let filteredSymbols = symbols.filter{
                $0.category == category
            }
            
            ForEach(filteredSymbols, id: \.self){ symbol in
                let symbolName = symbol.symbolName
                
                CircleElementButton(color: color, isSelected: selectedSymbol == symbolName, symbolName: symbolName, symbolColor: .white)
                {
                    selectedSymbol = symbolName
                }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        
        
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(selectedSymbol: .constant(symbols[0].symbolName), showSearch: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


