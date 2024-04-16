//
//  Symbols.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//
import SwiftUI

///All the categories of symbols
///
///This type is used for the ``SymbolsListView``
enum symbolsCategory: String, CaseIterable{
    case leisure = "theatermasks"
    case music = "music.note"
    case transportation = "car.fill"
    case nature = "leaf"
    case objects = "text.book.closed.fill"
    case health = "stethoscope"
    case stationery = "doc.text"
    case school = "backpack"
    case tools = "hammer"
    case fitness = "figure.run"
    case people = "person.fill"
    
    ///The Symbol associated to the category
    var symbol: String {
        self.rawValue
    }
    ///The name of the category
    var name: String {
        String(describing: self)
    }
    ///Keywords associated to the category
    ///
    ///Used to enhance the symbol search
    var keywords: String {
        switch self {
        case .health:
            return "medicine doctor covid illness"
        case .objects:
            return ""
        case .music:
            return "song singing concert playing listening"
        case .transportation:
            return "trip travel road vacation"
        case .people:
            return "person figure friends"
        case .fitness:
            return "sport game gym workout activity playing"
        case .leisure:
            return "freetime fun relax"
        case .tools:
            return "construction building diy"
        case .school:
            return "university study"
        case .stationery:
            return "school job work study"
        case .nature:
            return "wood"
        }
    }
}

///This Type holds additional information relevant to `SFSymbols`,
///such as a name to display, a category and keywords to enhance searching.
struct Symbol: Hashable{
    ///The name of the `SFSymbol`
    var symbolName: String
    ///A name that describes the symbol, displayed in the ``SymbolsListView``
    var displayName: String
    ///The category of the symbol
    var category: symbolsCategory
    ///Keywords are used to enhance the symbol search
    ///
    ///This `String` combines keywords specific to the symbol, the ``Symbol/symbolName``, the category's ``symbolsCategory/name`` and ``symbolsCategory/keywords``.
    var keywords: String
    
    ///A basic init to use when the ``displayName`` should be the same as ``symbolName``
    init(_ symbolName: String, _ category: symbolsCategory) {
        self.init(symbolName, symbolName, category)
    }
    ///The standard init
    init(_ symbolName: String, _ displayName: String, _ category: symbolsCategory) {
        self.init(symbolName, displayName, category, kw: "")
    }
    
    /// An init to use when there are additional keywords specific to the symbol to add
    /// - Parameters:
    ///   - keywords: Additional keywords specific to the symbol
    init(_ symbolName: String, _ category: symbolsCategory, kw keywords: String) {
        self.init(symbolName, symbolName, category, kw: keywords)
    }
    
    /// An init to use when there are additional keywords specific to the symbol to add
    /// - Parameters:
    ///   - keywords: Additional keywords specific to the symbol
    init(_ symbolName: String, _ displayName: String, _ category: symbolsCategory, kw keywords: String) {
        self.symbolName = symbolName
        self.displayName = displayName
        self.category = category
        self.keywords = keywords + symbolName + category.name + category.keywords
    }
}

