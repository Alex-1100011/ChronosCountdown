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
            
            //Suggested
            Section{
                Text("...")
            } header: {
                Label("Suggested", systemImage: "wand.and.stars.inverse")
            }
            
            //Recents
            Section{
                Text("...")
            } header: {
                Label("Recents", systemImage: "clock.arrow.circlepath")
            }
            
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
        symbols.filter {
            $0.contains(searchText.lowercased())
        }
    }
    
    var body: some View{
        List{
            ForEach(filteredList, id: \.self){ symbol in
                SymbolListRow(symbol: symbol, selectedSymbol: $selectedSymbol)
            }
        }
    }
    
    var symbols = ["hourglass","tram.fill","car.fill","bus.fill","ferry.fill","bicycle","fuelpump.fill","allergens","pawprint.fill","pencil.and.outline","paintbrush.fill","house.fill","gamecontroller.fill","desktopcomputer","printer.filled.and.paper","keyboard.fill","text.book.closed.fill"]
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
                CircleElementView(symbolName: symbol, symbolColor: Color.white)
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
