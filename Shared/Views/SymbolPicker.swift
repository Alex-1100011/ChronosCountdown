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
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))], spacing: 15){
            
            CircleElementView(color: Color(UIColor.tertiarySystemGroupedBackground), symbolName: "magnifyingglass", symbolColor: .secondary)
            {
                //Display search
            }
            
            ForEach(symbols, id: \.self) { symbol in
                CircleElementView(color: color, isSelected: selectedSymbol == symbol, symbolName: symbol, symbolColor: .white)
                {
                    selectedSymbol = symbol
                }
            }
        }
    }
    
    var symbols = ["hourglass","tram.fill","car.fill","bus.fill","ferry.fill","bicycle","fuelpump.fill","allergens","pawprint.fill","pencil.and.outline","paintbrush.fill","house.fill","gamecontroller.fill","desktopcomputer","printer.filled.and.paper","keyboard.fill","text.book.closed.fill"]
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(selectedSymbol: .constant("hourglass"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
