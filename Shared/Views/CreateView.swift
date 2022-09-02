//
//  CreateView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

struct CreateView: View {
    @State var counter = Counter(name: "", date: Date(), color: .blue, symbolName: "hourglass")
    var body: some View {
        List {
            Section("Background"){
                Text("Background")
            }
            
            Section("Date"){
                DatePicker("Date", selection: $counter.date, displayedComponents: .date)
                    .accentColor(counter.color)
                    .datePickerStyle(.graphical)
            }
            
            Section("Symbol"){
                Text("Symbol")
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
