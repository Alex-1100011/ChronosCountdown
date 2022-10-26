//
//  DataController.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 22/05/22.
//

import Foundation
import CoreData

///The `ViewModel` that manages all the CRUD operations on the ``DataController/counters``
class DataController: ObservableObject{
    ///The CoreData `Persistent Container`
    let container = NSPersistentContainer(name: "Chronos")
    ///The list of counters
    @Published var counters: [Counter] = []
    ///The stored CoreData entities
    private var entities: [CounterDataEntity] = []
    
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
    
    //CRUD operations
    
    //MARK: Create
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
    
    //MARK: Read
    ///A function that fetches ``counters`` from the Core Data ``container``
    func fetchCounters(){
        //Making the fetch request
        let request = NSFetchRequest<CounterDataEntity>(entityName: "CounterDataEntity")
        entities = (try? container.viewContext.fetch(request)) ?? []
        
        ///Updating the ``counters`` variable with the converted entities (from ``CounterDataEntity`` to ``Counter`` type)
        counters = entities.map{
            Counter(from: $0)
        }
        
    }
    
    //MARK: Update
    ///Updates a stored counter with the provided counter
    ///
    ///The stored counter is retrieved from the ``Counter/id`` of the provided counter, so it should not be changed.
    func update(_ counter: Counter){
        //Gets the stored entity
        if let entity = entities.first(where: {$0.id == counter.id}) {
            //Updates the counter entity
            entity.name = counter.name
            entity.date = counter.date
            entity.color = String(counter.color)
            entity.symbolName = counter.symbolName
            entity.image = counter.image?.jpegData(compressionQuality: 0.5)
            
            //Saves the changes
            saveData()
        }
    }
    
    //MARK: Delete
    ///Deletes a ``Counter`` from the CoreData `Persistent Container`
    func delete(_ counter: Counter){
        //Gets the stored entity
        if let entity = entities.first(where: {$0.id == counter.id}){
            //Deletes the entity
            container.viewContext.delete(entity)
            //Saves the CD context
            saveData()
        }
    }
    
    
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
    
    ///The `index of the specified counter in the ``DataController/counters`` list
    func getCounterIndex(counter: Counter) -> Int? {
        counters.firstIndex(where: {$0.id == counter.id})
    }
    
}

