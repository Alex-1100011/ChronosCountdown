//
//  SymbolSearchView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//

import SwiftUI

struct SymbolsView: View {
    @State private var searchText = ""
    @Binding var symbol: String
    
    private var isSearching: Bool {
        searchText != ""
    }
    
    var body: some View {
        NavigationView {
            
            Group{
                if isSearching {
                    SymbolsSearchView(searchText: $searchText)
                } else {
                    SymbolsListView()
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Symbols")
        }
    }
}

struct SymbolsListView: View {
    var body: some View {
        List {
            Section{
                Text("Hello")
                Text("Hello")
            } header: {
                Label("Suggested", systemImage: "wand.and.stars.inverse")
            }
            
            Section{
                Text("Hello")
                Text("Hello")
            } header: {
                Label("Recents", systemImage: "clock.arrow.circlepath")
            }
            
            Section{
                Text("Hello")
                Text("Hello")
            } header: {
                Label("Transportation", systemImage: "car.fill")
            }
        }
    }
}



struct SymbolsSearchView: View{
    @Binding var searchText: String
    var filteredList: [String] {
        symbols.filter {
            $0.contains(searchText.lowercased())
        }
    }
    
    var body: some View{
        List{
            ForEach(filteredList, id: \.self){ symbol in
                Label(symbol, systemImage: symbol)
            }
        }
    }
    
    var symbols = ["hourglass","tram.fill","car.fill","bus.fill","ferry.fill","bicycle","fuelpump.fill","allergens","pawprint.fill","pencil.and.outline","paintbrush.fill","house.fill","gamecontroller.fill","desktopcomputer","printer.filled.and.paper","keyboard.fill","text.book.closed.fill"]
}


struct SymbolSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsView(symbol: .constant("hello"))
    }
}
