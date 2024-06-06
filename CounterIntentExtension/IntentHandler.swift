////
////  IntentHandler.swift
////  CounterIntentExtension
////
////  Created by Alessandro Alberti on 16/09/22.
////
//
//import Intents
//
//class IntentHandler: INExtension, SelectCounterIntentHandling {
//    
//    override func handler(for intent: INIntent) -> Any {
//        return self
//    }
//    
//    func provideCounterOptionsCollection(for intent: SelectCounterIntent, with completion: @escaping (INObjectCollection<CounterSelection>?, Error?) -> Void) {
//        
//        //Fetch counters from CoreData
//        let data = DataController()
//        
//        //Convert counters into [CounterSelection]
//        let counters: [CounterSelection] = data.counters.map { counter in
//            let counterSelection = CounterSelection(
//                identifier: counter.id.uuidString,
//                display: counter.name)
//            
//            counterSelection.name = counter.name
//            counterSelection.id = counter.id.uuidString
//            
//            return counterSelection
//        }
//        
//        // Create a collection with the array of counters.
//        let collection = INObjectCollection(items: counters)
//        
//        // Call the completion handler, passing the collection.
//        completion(collection, nil)
//    }
//    
//    func defaultCounter(for intent: SelectCounterIntent) -> CounterSelection? {
//        //Fetch counters from CoreData
//        let data = DataController()
//        
//        //If there's at least 1 element
//        if data.counters.count != 0 {
//            let counter = data.counters[0]
//            
//            //Convert the first counter into CounterSelection
//            let counterSelection = CounterSelection(
//                identifier: counter.id.uuidString,
//                display: counter.name)
//            
//            counterSelection.name = counter.name
//            counterSelection.id = counter.id.uuidString
//            
//            return counterSelection
//        }
//
//        return nil
//    }
//}
//
//
