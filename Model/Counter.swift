//
//  CounterVM.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 22/05/22.
//

import Foundation
import SwiftData
import SwiftUI

#if os(macOS)
typealias SystemImage = NSImage
#else
typealias SystemImage = UIImage
#endif

@Model
class Counter: Identifiable {
    
    var name: String
    var date: Date
    var symbolName: String
    var id: UUID
    
    private var colorHex: String?
    private var imageData: Data?
    
    convenience init() {
        self.init(name: "", date: Date(), symbolName: "balloon.2", colorHex: "027AFF")
    }
    
    init(name: String, date: Date, symbolName: String, colorHex: String?, imageData: Data? = nil, id: UUID = UUID()) {
        self.name = name
        self.date = date
        self.symbolName = symbolName
        self.colorHex = colorHex
        self.imageData = imageData
        self.id = id
    }
    
    /// Returns a copy of itself
    ///
    /// Can be used to avoid editing the same reference of a ``Counter``
    func copy() -> Counter {
        Counter(
            name: name,
            date: date,
            symbolName: symbolName,
            colorHex: colorHex,
            imageData: imageData,
            id: id
        )
    }
    
    /// Sets all of its properties from the provided ``Counter``
    func copy(from counter: Counter){
        self.name = counter.name
        self.date = counter.date
        self.symbolName = counter.symbolName
        self.colorHex = counter.colorHex
        self.imageData = counter.imageData
    }
    
    //TODO: remove
    private var todayDate: Date = Date()
    
}

extension Counter {
    
    var color: Color {
        get {
            guard let colorHex else { return .blue }
            return Color(hex: colorHex)
        }
        set(newColor) {
            colorHex = newColor.hex
        }
    }
    
    var image: SystemImage? {
        get {
            guard let imageData else {
                return nil
            }
            #if os(macOS)
            return NSImage(data: imageData)
            #else
            return UIImage(data: imageData)
            #endif
        }
        set(newImage) {
            #if os(macOS)
            imageData = newImage?.tiffRepresentation
            #else
            imageData = newImage?.jpegData(compressionQuality: 0.5)
            #endif
        }
    }
    

    
    
    
    
    

    
    
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
    
    
    ///Returns true if the event is on the current day
    var isToday: Bool{
        getCounterComponents(type: .showOnlyDays).days == 0
    }
    
    /// This function returns the components of the countdown from ``date``
    /// - Parameter type: the type of components to be included
    /// - Returns: A tuple with all the components as `Integers`
    func getCounterComponents(type: Types) -> CounterComponents{
        let calendar = Calendar.current
        
        //Excluding time from the dates
        let todayComponents = Calendar.current.dateComponents([.year,.month,.day], from: todayDate)
        let today = Calendar.current.date(from: todayComponents)!
        
        let eventComponents = Calendar.current.dateComponents([.year,.month,.day], from: date)
        let event = Calendar.current.date(from: eventComponents)!
        
        
        ///Difference between `today` and `event`
        let components = calendar.dateComponents([.day, .month, .year], from: today, to: event)
        
        switch type {
        //Days
        case .showOnlyDays:
            let days = calendar.dateComponents([.day], from: today, to: event).day!
            return CounterComponents(days: days, weeks: 0, months: 0, years: 0)
        //Weeks
        case .showWeeks:
            var days = components.day!
            let weeks = Int(days/7)
            days -= weeks*7
            return CounterComponents(days: days, weeks: weeks, months: components.month!, years: components.year!)
        //Years
        case .showYears:
            return CounterComponents(days: components.day!, weeks: 0, months: components.month!, years: components.year!)
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
//    init(days: Double = 0, referenceDate: Date = Date()){
//        self.name = ""
//        self.date = Date() + (days * 24 * 60 * 60)
//        self.color = Color(hex: "027AFF")
//        self.symbolName = "balloon.2"
//        self.image = nil
//        self.id = UUID()
//        self.todayDate = Date()
//        self.referenceDate = referenceDate
//        
//    }
//    
//    init(name: String, date: Date, color: Color, symbolName: String, image: UIImage? = nil, referenceDate: Date = Date()) {
//        self.name = name
//        self.date = date
//        self.color = color
//        self.symbolName = symbolName
//        self.image = image
//        self.id = UUID()
//        self.todayDate = Date()
//        self.referenceDate = referenceDate
//    }
//    
//    ///instantiate a new ``Counter`` from a CoreData's ``CounterDataEntity``
//    init(from entity: CounterDataEntity){
//        name = entity.name ?? ""
//        date = entity.date ?? Date()
//        color = Color(hex: entity.color ?? "027AFF")
//        symbolName = entity.symbolName ?? ""
//        id = entity.id!
//        if let imageData = entity.image {
//            image = UIImage(data: imageData)
//        }
//        self.todayDate = Date()
//        self.referenceDate = Date()
//        
//    }

}



///A struct containing all the components of the ``Counter``
struct CounterComponents: Equatable{
    var days: Int
    var weeks: Int
    var months: Int
    var years: Int
}
