//
//  SymbolPicker.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 02/09/22.
//

import SwiftUI

//MARK: SymbolPicker
///This `View` lets the user select a symbol, passed with the binding variable ``SymbolPicker/selectedSymbol``
struct SymbolPicker: View {
    ///The accent color of the elements
    var color: Color
    ///The symbol selected by the user
    @Binding var selectedSymbol: String
    ///When the search button is tapped this variable turns to `true` and the ``SymbolsView`` should be displayed by the `parent view`
    @Binding var showSearch: Bool
    @State private var tabSelection = symbolsCategory.allCases[0]
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            ForEach(symbolsCategory.allCases, id: \.self) { category in
                
                ScrollView {
                    SymbolGrid(color: color, selectedSymbol: $selectedSymbol, showSearch: $showSearch, category: category)
                }
                .tabItem({Label(category.name, systemImage: category.symbol)})
                .tag(category)
                
            }
        }
        .frame(height: 300)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        .onChange(of: selectedSymbol){ newSymbol in
            updateTabSelection(with: newSymbol)
        }
    }
    
    func updateTabSelection(with symbolName: String){
        if let symbol = symbols.first(where: {$0.symbolName == symbolName}){
            tabSelection = symbol.category
        }
    }

    init(color: Color = .blue, selectedSymbol: Binding<String>, showSearch: Binding<Bool>) {
        self.color = color
        self._selectedSymbol = selectedSymbol
        self._showSearch = showSearch
        
        //Set the page indicator color and selection
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.secondaryLabel
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.tertiaryLabel
        updateTabSelection(with: selectedSymbol.wrappedValue)
    }
}

//MARK: SymbolGrid
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
        //Space for the page control
        .padding(.bottom, 45)
        .frame(maxHeight: .infinity)
        
        
    }
}

//MARK: Previews
struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(selectedSymbol: .constant(symbols[0].symbolName), showSearch: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


