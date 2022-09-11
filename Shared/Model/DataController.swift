//
//  DataController.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 22/05/22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    ///The CoreData `Persistent Container`
    let container = NSPersistentContainer(name: "Chronos")
    ///The list of counters
    @Published var counters: [Counter] = []
    
    init(){
        //Assigning the AppGroup's storing URL
        let storeURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.Alessandro.Alberti.Chronos-Countdown")!
            .appendingPathComponent("Chronos.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]
        
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
            ///Updating the ``counters`` variable with the entities converted from the ``CounterDataEntity`` to ``Counter`` type
            counters = entities.map{
                Counter(from: $0)
            }
        }
    }
    
    ///This function adds a new ``Counter`` to the ``counters``
    func add(_ counter: Counter){
        let counterEntity = CounterDataEntity(context: container.viewContext)
        counterEntity.name = counter.name
        counterEntity.date = counter.date
        counterEntity.color = String(counter.color)
        counterEntity.symbolName = counter.symbolName
        counterEntity.image = counter.image?.pngData()
        
        save()
    }
    
    ///This function saves the ``container``'s context and updates the ``counters``
    private func save(){
        try? container.viewContext.save()
        fetchCounters()
    }
    
}

