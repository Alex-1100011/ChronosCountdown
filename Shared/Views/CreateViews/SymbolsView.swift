//
//  SymbolSearchView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//

import SwiftUI

//MARK: SymbolsView
///This `View` shows all the symbols in a searchable list with the corresponding names, in a more accessible way
///The selected symbol can be changed tapping on the ``SymbolListRow``, so the ``SymbolsView/symbol`` is a `binding`
struct SymbolsView: View {
    ///The selected symbol
    @Binding var symbol: String
    ///To dismiss itself
    @Binding var showSymbolsView: Bool
    ///The accent color of the view
    var color: Color
    ///The searched text
    @State private var searchText = ""
    ///When the user actually types something
    private var isSearching: Bool {
        searchText != ""
    }
    
    var body: some View {
        NavigationView {
            
            Group{
                if isSearching {
                    SymbolsSearchView(
                        selectedSymbol: $symbol,
                        showSymbolsView: $showSymbolsView,
                        searchText: searchText
                    )
                } else {
                    SymbolsListView(
                        selectedSymbol: $symbol,
                        showSymbolsView: $showSymbolsView
                    )
                }
            }
            .tint(color)
            .searchable(text: $searchText)
            .navigationTitle("Symbols")
        }
    }
}

//MARK: SymbolsListView
///The `list` of all the ``symbols`` divided by categories.
///
///It is shown when the user isn't using the search field.
struct SymbolsListView: View {
    @Binding var selectedSymbol: String
    ///To dismiss itself
    @Binding var showSymbolsView: Bool
    
    var body: some View {
        List {
            
            //Categories
            ForEach(symbolsCategory.allCases, id: \.self){ category in
                Section{
                    let filteredSymbols = symbols.filter{
                        $0.category == category
                    }
                    ForEach(filteredSymbols, id: \.self){ symbol in
                        SymbolListRow(
                            symbol: symbol,
                            selectedSymbol: $selectedSymbol,
                            showSymbolsView: $showSymbolsView)
                    }
                } header: {
                    Label(category.name, systemImage: category.symbol)
                }
            }
        }
    }
}



//MARK: SymbolsSearchView
///This `View` shows the search results from the ``SymbolsSearchView/searchText`` variable.
struct SymbolsSearchView: View {
    @Binding var selectedSymbol: String
    @Binding var showSymbolsView: Bool
    ///The text of the user's query
    var searchText: String
    
    var body: some View{
        List{
            ForEach(filteredList, id: \.self){ symbol in
                SymbolListRow(
                    symbol: symbol,
                    selectedSymbol: $selectedSymbol,
                    showSymbolsView: $showSymbolsView)
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
    var filteredList: [Symbol] {
        //Lists
        var matchName = [Symbol]()
        var prefixName = [Symbol]()
        var containsName = [Symbol]()
        var containsKeyword = [Symbol]()
        
        let query = searchText.lowercased()
        
        //Do the query
        for symbol in symbols {

            if query == symbol.displayName {
                matchName.append(symbol)
                
            } else if symbol.displayName.hasPrefix(query) {
                prefixName.append(symbol)
                
            } else if symbol.displayName.contains(query) {
                containsName.append(symbol)
                
            } else if symbol.keywords.contains(query) {
                containsKeyword.append(symbol)
            }
        }
        
        //Sort the results
        matchName.sort{
            $0.displayName < $1.displayName
        }
        prefixName.sort{
            $0.displayName < $1.displayName
        }
        containsName.sort{
            $0.displayName < $1.displayName
        }
        containsKeyword.sort{
            $0.displayName < $1.displayName
        }
        //Return with the priority order
        return matchName + prefixName + containsName + containsKeyword
    }
}

//MARK: SymbolListRow
///The row for the ``SymbolsListView`` and ``SymbolsSearchView``, it shows the selectable symbols with their names and a checkmark if it's selected
struct SymbolListRow: View{
    var symbol: Symbol
    @Binding var selectedSymbol: String
    @Binding var showSymbolsView: Bool
    
    var body: some View{
        Button {
            selectedSymbol = symbol.symbolName
            showSymbolsView = false
        } label: {
            HStack {
                CircleElementView(symbolName: symbol.symbolName, symbolColor: Color.white, circleSize: 30)
                Text(symbol.displayName.capitalizeFirstLetter())
                Spacer()
                
                if symbol.symbolName == selectedSymbol {
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
        SymbolsView(symbol: .constant("hourglass"), showSymbolsView: .constant(true), color: .red)
        
        SymbolsSearchView(selectedSymbol: .constant("hourglass"), showSymbolsView: .constant(true), searchText: "a")
            .tint(.green)
    }
}
