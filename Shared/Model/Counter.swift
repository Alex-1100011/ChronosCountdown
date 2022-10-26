//
//  CounterVM.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 22/05/22.
//

import Foundation
import CoreData
import SwiftUI

struct Counter: Identifiable{
    ///The name of the event
    var name: String
    ///The date of the event
    var date: Date
    var color: Color
    var symbolName: String
    var image: UIImage?
    var id: UUID
    
    ///This variable stores the reference today's Date for counting down to the ``date`` variable
    ///
    ///It automatically excludes the time from the date.
    ///It is used in the timeline ``Provider`` to get future versions of the counters for the widgets
    var referenceDate: Date {
        get {todayDate}
        set (newDate) {
            ///Excluding the time from  `todayDate`
            let todayComponents = Calendar.current.dateComponents([.year,.month,.day], from: newDate)
            self.todayDate = Calendar.current.date(from: todayComponents)!
        }
    }
    private var todayDate: Date
    
    ///Returns true if the event is on the current day
    var isToday: Bool{
        getCounterComponents(type: .showOnlyDays).days == 0
    }
    
    /// This function returns the components of the countdown from ``date``
    /// - Parameter type: the type of components to be included
    /// - Returns: A tuple with all the components as `Integers`
    func getCounterComponents(type: Types) -> counterComponents{
        let calendar = Calendar.current
        
        
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
    
    ///Instantiates a counter with default values
    ///
    ///Used when creating new counters in the ``CreateView``
    init(days: Double = 0, referenceDate: Date = Date()){
        self.name = "Title"
        self.date = Date() + (days * 24 * 60 * 60)
        self.color = Color(hex: "027AFF")
        self.symbolName = "hourglass"
        self.image = nil
        self.id = UUID()
        self.todayDate = Date()
        self.referenceDate = referenceDate
        
    }
    
    init(name: String, date: Date, color: Color, symbolName: String, image: UIImage? = nil, referenceDate: Date = Date()) {
        self.name = name
        self.date = date
        self.color = color
        self.symbolName = symbolName
        self.image = image
        self.id = UUID()
        self.todayDate = Date()
        self.referenceDate = referenceDate
    }
    
    ///instantiate a new ``Counter`` from a CoreData's ``CounterDataEntity``
    init(from entity: CounterDataEntity){
        name = entity.name ?? ""
        date = entity.date ?? Date()
        color = Color(hex: entity.color ?? "027AFF")
        symbolName = entity.symbolName ?? ""
        id = entity.id!
        if let imageData = entity.image {
            image = UIImage(data: imageData)
        }
        self.todayDate = Date()
        self.referenceDate = Date()
        
    }

}

///A tuple containing all the components of the ``Counter``
typealias counterComponents = (days: Int, weeks: Int, months: Int, years: Int)
