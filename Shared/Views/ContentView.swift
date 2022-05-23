//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    
    var body: some View {
        ScrollView {
            ForEach(dataController.counters){ counter in
                CounterTopView(counter: counter, type: .showWeeks)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.blue)
                    }
            }
            Button("Add"){
                let counter = Counter(
                    name: "Test",
                    date: Date() + 60 * 60 * 24 * Double(Int.random(in: 1...60)),
                    color: .blue,
                    symbolName: "")
                dataController.add(counter)
            }
        }
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataController())
    }
}
