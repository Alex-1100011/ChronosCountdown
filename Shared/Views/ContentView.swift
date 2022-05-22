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
        List{
            ForEach(dataController.counters){ counter in
                Text(counter.name)
            }
            Button("Add"){
                let counter = Counter(name: "Test", date: Date(), color: .blue, symbolName: "")
                dataController.add(counter)
            }
        }
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
