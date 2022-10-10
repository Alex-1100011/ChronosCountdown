//
//  Symbols.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//
import SwiftUI

enum symbolsCategory: String, CaseIterable{
    case stationery = "doc.text"
    case school = "backpack"
    case tools = "hammer"
    case objects = "text.book.closed.fill"
    case music = "music.note"
    case leisure = "theatermasks"
    case transportation = "car.fill"
    case health = "stethoscope"
    case fitness = "figure.run"
    case people = "person.fill"
    
    
    var symbol: String {
        self.rawValue
    }
    var name: String {
        String(describing: self)
    }
    var keywords: String {
        switch self {
        case .health:
            return "medicine doctor covid illness"
        case .objects:
            return ""
        case .music:
            return ""
        case .transportation:
            return "trip travel road"
        case .people:
            return ""
        case .fitness:
            return ""
        case .leisure:
            return "freetime fun relax"
        case .tools:
            return ""
        case .school:
            return ""
        case .stationery:
            return ""
        }
    }
}

struct Symbol{
    var symbolName: String
    var displayName: String
    var category: symbolsCategory
    var keywords: String
    
    ///A basic init to use when the ``displayName`` should be the ``symbolName``
    init(_ symbolName: String, _ category: symbolsCategory) {
        self.init(symbolName, symbolName, category)
    }
    ///The regular init
    init(_ symbolName: String, _ displayName: String, _ category: symbolsCategory) {
        self.init(symbolName, displayName, category, kw: "")
    }
    
    ///An init to use when there are additional keywords specific to the symbol to add
    init(_ symbolName: String, _ displayName: String, _ category: symbolsCategory, kw keywords: String) {
        self.symbolName = symbolName
        self.displayName = symbolName
        self.category = category
        self.keywords = keywords + symbolName + category.name + category.keywords
    }
}

var symbols: [Symbol] = [
    
    //MARK: Transportation
    Symbol("car", .transportation),
    Symbol("tram", .transportation),
    Symbol("cablecar", .transportation),
    Symbol("bus", .transportation),
    Symbol("ferry", .transportation),
    Symbol("airplane", .transportation),
    Symbol("bicycle", .transportation),
    Symbol("scooter", .transportation),
    Symbol("fuelpump", .transportation),
    Symbol("sailboat", .transportation),
    Symbol("road.lanes", .transportation),
    
    //MARK: People
    Symbol("person", .people),
    Symbol("person.2", .people),
    Symbol("person.3", .people),
    Symbol("figure.stand", .people),
    Symbol("figure.wave", .people),
    Symbol("figure.walk", .people),
    Symbol("figure.roll", .people),
    
    //MARK: Music
    Symbol("music.note", .music),
    Symbol("music.mic", .music),
    Symbol("music.quarternote.3", .music),
    Symbol("guitars", .music),
    Symbol("pianokeys", .music),
    Symbol("headphones", .music),
    Symbol("mic.fill", .music),
    Symbol("earbuds", .music),
    Symbol("hifispeaker", .music),
    Symbol("speaker.wave.2", .music),
    Symbol("hifispeaker.2", .music),
    Symbol("dial.low", .music),
    Symbol("metronome", .music),
    Symbol("tuningfork", .music),
    Symbol("amplifier", .music),
    
    //MARK: Fitness
    Symbol("sportscourt", .fitness),
    Symbol("dumbbell", .fitness),
    Symbol("soccerball", .fitness),
    Symbol("baseball", .fitness),
    Symbol("basketball", .fitness),
    Symbol("football", .fitness),
    Symbol("cricket.ball", .fitness),
    Symbol("tennisball", .fitness),
    Symbol("volleyball", .fitness),
    Symbol("tennis.racket", .fitness),
    Symbol("trophy", .fitness),
    Symbol("medal", .fitness),
    Symbol("flag.checkered.2.crossed", .fitness),
    Symbol("figure.walk", .fitness),
    Symbol("figure.run", .fitness),
    Symbol("figure.roll.runningpace", .fitness),
    Symbol("figure.american.football", .fitness),
    Symbol("figure.archery", .fitness),
    Symbol("figure.australian.football", .fitness),
    Symbol("figure.badminton", .fitness),
    Symbol("figure.barre", .fitness),
    Symbol("figure.baseball", .fitness),
    Symbol("figure.basketball", .fitness),
    Symbol("figure.bowling", .fitness),
    Symbol("figure.boxing", .fitness),
    Symbol("figure.climbing", .fitness),
    Symbol("figure.cooldown", .fitness),
    Symbol("figure.core.training", .fitness),
    Symbol("figure.cricket", .fitness),
    Symbol("figure.skiing.downhill", .fitness),
    Symbol("figure.cross.training", .fitness),
    Symbol("figure.curling", .fitness),
    Symbol("figure.disc.sports", .fitness),
    Symbol("figure.elliptical", .fitness),
    Symbol("figure.equestrian.sports", .fitness),
    Symbol("figure.fencing", .fitness),
    Symbol("figure.fishing", .fitness),
    Symbol("figure.golf", .fitness),
    Symbol("figure.handball", .fitness),
    Symbol("figure.highintensity.intervaltraining", .fitness),
    Symbol("figure.hiking", .fitness),
    Symbol("figure.hockey", .fitness),
    Symbol("figure.indoor.cycle", .fitness),
    Symbol("figure.outdoor.cycle", .fitness),
    Symbol("figure.strengthtraining.traditional", .fitness),
    Symbol("figure.volleyball", .fitness),
    
    //MARK: Health
    Symbol("cross.case", .health),
    Symbol("medical.thermometer", .health),
    Symbol("bandage", .health),
    Symbol("syringe", .health),
    Symbol("facemask", .health),
    Symbol("pills", .health),
    Symbol("cross", .health),
    Symbol("cross.vial", .health),
    Symbol("ivfluid.bag", .health),
    Symbol("staroflife", .health),
    Symbol("allergens", .health),
    Symbol("waveform.path.ecg", .health),
    Symbol("brain.head.profile", .health),
    Symbol("testtube.2", .health),
    Symbol("stethoscope", .health),
    
    //MARK: Leisure
    Symbol("popcorn", .leisure),
    Symbol("ticket", .leisure),
    Symbol("theatermasks", .leisure),
    Symbol("puzzlepiece", .leisure),
    Symbol("building.columns", .leisure),
    Symbol("tv.inset.filled", .leisure),
    Symbol("radio", .leisure),
    Symbol("checkerboard.rectangle", .leisure),
    Symbol("gamecontroller", .leisure),
    Symbol("app.gift", .leisure),
    Symbol("party.popper", .leisure),
    Symbol("binoculars", .leisure),
    Symbol("tent", .leisure),
    Symbol("beach.umbrella", .leisure),
    Symbol("balloon.2", .leisure),
    Symbol("fireplace", .leisure),
    Symbol("film.stack", .leisure),
    Symbol("birthday.cake", .leisure),
    
    //MARK: Objects
    Symbol("hourglass", .objects),
    Symbol("pencil", .stationery),
    Symbol("eraser", .stationery),
    Symbol("square.and.pencil", .stationery),
    Symbol("highlighter", .stationery),
    Symbol("pencil.and.outline", .stationery),
    Symbol("trash", .objects),
    Symbol("folder", .stationery),
    Symbol("paperplane", .school),
    Symbol("tray.full", .stationery),
    Symbol("doc.text", .stationery),
    Symbol("list.bullet.clipboard", .stationery),
    Symbol("note.text", .objects),
    Symbol("calendar", .objects),
    Symbol("book", .school),
    Symbol("books.vertical", .school),
    Symbol("text.book.closed", .school),
    Symbol("newspaper", .objects),
    Symbol("graduationcap", .school),
    Symbol("ruler", .stationery),
    Symbol("backpack", .school),
    Symbol("studentdesk", .school),
    Symbol("paperclip", .stationery),
    Symbol("link", .stationery),
    Symbol("photo.artframe", .objects),
    Symbol("umbrella", .objects),
    Symbol("megaphone", .objects),
    Symbol("magnifyingglass", .stationery),
    Symbol("bell", .school),
    Symbol("tag", .stationery),
    Symbol("flashlight.on.fill", .objects),
    Symbol("camera", .objects),
    Symbol("gearshape", .tools),
    Symbol("gearshape.2", .tools),
    Symbol("scissors", .stationery),
    Symbol("bag", .objects),
    Symbol("cart", .objects),
    Symbol("basket", .objects),
    Symbol("creditcard", .objects),
    Symbol("wand.and.rays", .objects),
    Symbol("creditcard", .objects),
    Symbol("die.face.5", .leisure),
    Symbol("paintbrush", .objects),
    Symbol("paintbrush.pointed", .objects),
    Symbol("level", .tools),
    Symbol("wrench.adjustable", .tools),
    Symbol("hammer", .tools),
    Symbol("screwdriver", .tools),
    Symbol("eyedropper", .objects),
    Symbol("scroll", .objects),
    Symbol("printer", .stationery),
    Symbol("briefcase", .objects),
    Symbol("suitcase", .objects),
    Symbol("puzzlepiece.fill", .leisure),
    Symbol("building.2", .objects),
    Symbol("lock", .tools),
    Symbol("map", .leisure)
]

