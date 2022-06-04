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
    ///This state controls the size of the ``CounterCardView``
    @State var isAspectSmall = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(dataController.counters){ counter in
                    
                    CounterCardView(counter: counter, isSmall: isAspectSmall)
                }
            }
            .navigationBarTitle("Counters")
            //MARK: navigationBarItems
            .navigationBarItems(trailing:
             HStack {
                
                //Change card size button
                Button{
                    withAnimation{
                        isAspectSmall.toggle()
                    }
                } label: {
                    Label("Change card size", systemImage: isAspectSmall ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                }
                
                //Add new counter button
                Button{
                    let counter = Counter(
                        name: "Test",
                        date: Date() + 60 * 60 * 24 * Double(Int.random(in: 1...60)),
                        color: .blue,
                        symbolName: "command")
                    dataController.add(counter)
                } label: {
                    Label("Add new counter", systemImage: "plus")
                }
            })
        }
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataController())
    }
}
