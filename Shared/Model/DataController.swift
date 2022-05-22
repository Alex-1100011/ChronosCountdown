//
//  DataController.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 22/05/22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Chronos")
    @Published var counters: [Counter] = []
    
    init(){
        //Loading the Persistent Container
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        //Fetching the Counters
        fetchCounters()
    }
    
    ///A function that fetches ``counters`` from the Core Data ``container``
    func fetchCounters(){
        //Making the fetch request
        let request = NSFetchRequest<CounterDataEntity>(entityName: "CounterDataEntity")
        let entities = try? container.viewContext.fetch(request)
        
        if let entities = entities{
            ///Converting from ``CounterDataEntity`` to ``Counter``
            counters = entities.map{
                Counter(from: $0)
            }
        }
    }
    
    func add(_ counter: Counter){
        let counterEntity = CounterDataEntity(context: container.viewContext)
        counterEntity.name = counter.name
        counterEntity.date = counter.date
        counterEntity.color = String(describing: counter.color)
        counterEntity.symbolName = counter.symbolName
        
        try? container.viewContext.save()
        fetchCounters()
    }
    
}

