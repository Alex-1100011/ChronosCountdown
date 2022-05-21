//
//  Counter.swift
//  Chronos Countdown (iOS)
//
//  Created by Alessandro Alberti on 21/05/22.
//
//

import Foundation
import CoreData

@objc(Counter)
public class Counter: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext, name: String, date: Date, color: String, symbolName: String){
        
        self.init(context: context)
        
        self.name = name
        self.date = date
        self.color = color
        self.symbolName = symbolName
        self.id = UUID()
    }
    
    /// This function returns the components of the countdown from ``date``
    /// - Parameter type: the type of components to be included
    /// - Returns: A tuple with all the components as `Integers`
    func getCounterComponents(type: Types) -> (days: Int, weeks: Int, months: Int, years: Int){
        let calendar = Calendar.current
        var todayDate = Date()
        
        ///Excluding the time from  `todayDate`
        let todayComponents = calendar.dateComponents([.year,.month,.day], from: todayDate)
        todayDate = calendar.date(from: todayComponents)!
        
        ///Difference between `todayDate` and `date`
        let components = calendar.dateComponents([.day, .month, .year], from: todayDate, to: date ?? Date())
        
        switch type {
        //Days
        case .showOnlyDays:
            let days = calendar.dateComponents([.day], from: todayDate, to: date ?? Date()).day!
            return (days: days, weeks: 0, months: 0, years: 0)
        //Weeks
        case .showWeeks:
            var days = components.day!
            let weeks = Int(days/7)
            days -= weeks*7
            return (days: days, weeks: weeks, months: components.month!, years: components.year!)
        //Years
        case .showYears:
            return (days: components.day!, weeks: 0, months: components.month!, years: components.year!)
        }
    }
    
    ///The type of components that will be shown  in the ``CounterView``
    enum Types: Codable {
        ///Shows only the days components
        case showOnlyDays
        ///Shows days, weeks and months components
        case showWeeks
        ///Shows days, months and years components
        case showYears
    }
}
