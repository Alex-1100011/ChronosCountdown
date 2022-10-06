//
//  DataController.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 22/05/22.
//

import Foundation
import CoreData

///The ViewModel that manages ....
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
    
    //MARK: Fetch
    ///A function that fetches ``counters`` from the Core Data ``container``
    func fetchCounters(){
        //Making the fetch request
        let request = NSFetchRequest<CounterDataEntity>(entityName: "CounterDataEntity")
        let entities = try? container.viewContext.fetch(request)
        
        if let entities = entities{
            ///Updating the ``counters`` variable with the converted entities (from ``CounterDataEntity`` to ``Counter`` type)
            counters = entities.map{
                Counter(from: $0)
            }
        }
    }
    
    //MARK: Add
    ///Adds a new ``Counter`` to the CoreData `Persistent Container`
    func add(_ counter: Counter){
        let counterEntity = CounterDataEntity(context: container.viewContext)
        counterEntity.name = counter.name
        counterEntity.date = counter.date
        counterEntity.color = String(counter.color)
        counterEntity.symbolName = counter.symbolName
        counterEntity.image = counter.image?.jpegData(compressionQuality: 0.5)
        counterEntity.id = counter.id
        
        saveData()
    }
    
    //MARK: Delete
    ///Deletes a ``Counter`` from the CoreData `Persistent Container`
    func delete(_ counter: Counter){
        let request = NSFetchRequest<CounterDataEntity>(entityName: "CounterDataEntity")
        let entities = try? container.viewContext.fetch(request)
        
        if let entity = entities?.first(where: {$0.id == counter.id}){
            container.viewContext.delete(entity)
            saveData()
        }
    }
    
    //MARK: Save
    ///This function saves the ``container``'s context and updates the ``counters``
    private func saveData(){
        try? container.viewContext.save()
        fetchCounters()
    }
    
    
    /// This function ...
    /// - Parameter name: name description
    /// - Returns: description
    func getCounterNamed(_ name: String?)-> Counter? {
        counters.first(where: {$0.name == name})
    }
    
}

