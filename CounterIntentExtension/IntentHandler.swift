//
//  IntentHandler.swift
//  CounterIntentExtension
//
//  Created by Alessandro Alberti on 16/09/22.
//

import Intents

class IntentHandler: INExtension, SelectCounterIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func provideCounterOptionsCollection(for intent: SelectCounterIntent, with completion: @escaping (INObjectCollection<CounterSelection>?, Error?) -> Void) {
        
        //Fetch counters from CoreData
        let data = DataController()
        
        //Convert counters into [CounterSelection]
        let counters: [CounterSelection] = data.counters.map { counter in
            let counterSelection = CounterSelection(
                identifier: counter.name,
                display: counter.name)
            counterSelection.name = counter.name
            counterSelection.symbolName = counter.symbolName
            
            return counterSelection
        }
        
        // Create a collection with the array of counters.
        let collection = INObjectCollection(items: counters)
        
        // Call the completion handler, passing the collection.
        completion(collection, nil)
    }
    
    func defaultCounter(for intent: SelectCounterIntent) -> CounterSelection? {
        return nil
    }
}


