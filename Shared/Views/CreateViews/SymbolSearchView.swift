//
//  SymbolSearchView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//

import SwiftUI

struct SymbolSearchView: View {
    @Binding var text: String
    var body: some View {
        TextField("SFSymbol Name", text: $text)
            .padding()
    }
}

struct SymbolSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolSearchView(text: .constant("hello"))
    }
}
