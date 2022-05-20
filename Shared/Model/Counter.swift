//
//  Counter.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 20/05/22.
//

import Foundation
import SwiftUI

struct Counter: Identifiable{
    var name: String
    var date: Date
    var color: Color
    var symbolName: String
    
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
        let components = calendar.dateComponents([.day, .month, .year], from: todayDate, to: date)
        
        switch type {
        //Days
        case .showOnlyDays:
            let days = calendar.dateComponents([.day], from: todayDate, to: date).day!
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
    
    var id = UUID()
}
