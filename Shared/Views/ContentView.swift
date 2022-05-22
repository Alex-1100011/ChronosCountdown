//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObject
    @FetchRequest(sortDescriptors: []) var counters: FetchedResults<Counter>
    
    var body: some View {
        List{
            ForEach(counters){ counter in
                Text(counter.name ?? "")
            }
            Button("Add"){
                let _ = Counter(context: managedObject, name: "test", date: Date(), color: "", symbolName: "")
                try? managedObject.save()
            }
        }
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
