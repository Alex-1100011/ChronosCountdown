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
                    ForEach(filteredSymbols.map{$0.name}, id: \.self){ symbol in
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
    
    var filteredList: [String] {
        let s = symbols.filter {
            $0.name.contains(searchText.lowercased())
        }
        return s.map{
            $0.name
        }
    }
    
    var body: some View{
        List{
            ForEach(filteredList, id: \.self){ symbol in
                SymbolListRow(symbol: symbol, selectedSymbol: $selectedSymbol)
            }
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
