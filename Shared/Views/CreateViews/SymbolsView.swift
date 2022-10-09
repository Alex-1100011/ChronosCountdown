//
//  SymbolSearchView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//

import SwiftUI

//MARK: SymbolsView
struct SymbolsView: View {
    @Binding var symbol: String
    var color: Color
    
    @State private var searchText = ""
    private var isSearching: Bool {
        searchText != ""
    }
    
    var body: some View {
        NavigationView {
            
            Group{
                if isSearching {
                    SymbolsSearchView(selectedSymbol: $symbol, searchText: searchText)
                } else {
                    SymbolsListView(selectedSymbol: $symbol)
                }
            }
            .tint(color)
            .searchable(text: $searchText)
            .navigationTitle("Symbols")
        }
    }
}

//MARK: SymbolsListView
struct SymbolsListView: View {
    @Binding var selectedSymbol: String
    
    var body: some View {
        List {
            
            //Categories
            ForEach(symbolsCategory.allCases, id: \.self){ category in
                Section{
                    let filteredSymbols = symbols.filter{
                        $0.category == category
                    }
                    ForEach(filteredSymbols.map{$0.symbolName}, id: \.self){ symbol in
                        SymbolListRow(symbol: symbol, selectedSymbol: $selectedSymbol)
                    }
                } header: {
                    Label(category.name, systemImage: category.symbol)
                }
            }
        }
    }
}



//MARK: SymbolsSearchView
struct SymbolsSearchView: View{
    @Binding var selectedSymbol: String
    var searchText: String
    
    var body: some View{
        List{
            ForEach(filteredList, id: \.self){ symbol in
                SymbolListRow(symbol: symbol, selectedSymbol: $selectedSymbol)
            }
        }
    }
    
    ///Filters the ``symbols`` list based on the ``searchText``, using specific priorities.
    ///
    ///The list is ordered with priority to
    ///the matching string, than
    ///the ones that start with the same letters,
    ///the ones that contains the query in its name and at the end
    ///the ones that contains the query in the keywords.
    var filteredList: [String] {
        var matchName = [Symbol]()
        var prefixName = [Symbol]()
        var containsName = [Symbol]()
        var containsString = [Symbol]()
        
        let query = searchText.lowercased()
        
        for symbol in symbols {

            if query == symbol.displayName {
                matchName.append(symbol)
                
            } else if symbol.displayName.hasPrefix(query) {
                prefixName.append(symbol)
                
            } else if symbol.displayName.contains(query) {
                containsName.append(symbol)
                
            } else if symbol.keywords.contains(query) {
                containsString.append(symbol)
            }
        }

        let results = matchName + prefixName + containsName + containsString
        
        return results.map{
            $0.symbolName
        }
    }
}

//MARK: SymbolListRow
struct SymbolListRow: View{
    var symbol: String
    @Binding var selectedSymbol: String
    
    var body: some View{
        Button {
            selectedSymbol = symbol
        } label: {
            HStack {
                CircleElementView(symbolName: symbol, symbolColor: Color.white, circleSize: 30)
                Text(symbol.capitalizeFirstLetter())
                Spacer()
                
                if symbol == selectedSymbol {
                    Image(systemName: "checkmark")
                        .fontWeight(.bold)
                        .foregroundStyle(.tint)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}


struct SymbolSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsView(symbol: .constant("hourglass"), color: .red)
        
        SymbolsSearchView(selectedSymbol: .constant("hourglass"), searchText: "a")
            .tint(.green)
    }
}
