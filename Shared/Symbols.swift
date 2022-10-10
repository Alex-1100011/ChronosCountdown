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

struct Symbol: Hashable{
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
        self.displayName = displayName
        self.category = category
        self.keywords = keywords + symbolName + category.name + category.keywords
    }
}

var symbols: [Symbol] = [
    
    //MARK: objects
    Symbol("photo.artframe", "artframe", .objects),
    Symbol("bag", .objects),
    Symbol("basket", .objects),
    Symbol("briefcase", .objects),
    Symbol("building.2", "buildings", .objects),
    Symbol("calendar", .objects),
    Symbol("camera", .objects),
    Symbol("cart", .objects),
    Symbol("creditcard", .objects),
    Symbol("creditcard", .objects),
    Symbol("eyedropper", .objects),
    Symbol("flashlight.on.fill", "flashlight", .objects),
    Symbol("hourglass", .objects),
    Symbol("megaphone", .objects),
    Symbol("newspaper", .objects),
    Symbol("note.text", "note", .objects),
    Symbol("paintbrush", .objects),
    Symbol("paintbrush.pointed", "paintbrush", .objects),
    Symbol("scroll", .objects),
    Symbol("suitcase", .objects),
    Symbol("trash", .objects),
    Symbol("umbrella", .objects),
    Symbol("wand.and.rays", "wand", .objects),

    //MARK: music
    Symbol("amplifier", .music),
    Symbol("dial.low", "dial", .music),
    Symbol("earbuds", .music),
    Symbol("guitars", .music),
    Symbol("headphones", .music),
    Symbol("hifispeaker", .music),
    Symbol("hifispeaker.2", "hifispeakers", .music),
    Symbol("metronome", .music),
    Symbol("mic.fill", "mic", .music),
    Symbol("music.mic", "mic", .music),
    Symbol("music.note", "note", .music),
    Symbol("pianokeys", .music),
    Symbol("music.quarternote.3", "quarternote", .music),
    Symbol("speaker.wave.2", "speaker", .music),
    Symbol("tuningfork", .music),

    //MARK: leisure
    Symbol("balloon.2", "balloons", .leisure),
    Symbol("beach.umbrella", "beach umbrella", .leisure),
    Symbol("binoculars", .leisure),
    Symbol("birthday.cake", "birthday cake", .leisure),
    Symbol("checkerboard.rectangle", "chessboard", .leisure),
    Symbol("die.face.5", "die", .leisure),
    Symbol("film.stack", "film", .leisure),
    Symbol("fireplace", .leisure),
    Symbol("gamecontroller", .leisure),
    Symbol("app.gift", "gift", .leisure),
    Symbol("map", .leisure),
    Symbol("building.columns", "museum", .leisure),
    Symbol("party.popper", "party popper", .leisure),
    Symbol("popcorn", .leisure),
    Symbol("puzzlepiece", .leisure),
    Symbol("radio", .leisure),
    Symbol("tent", .leisure),
    Symbol("theatermasks", "theater", .leisure),
    Symbol("ticket", .leisure),
    Symbol("tv.inset.filled", "tv", .leisure),

    //MARK: transportation
    Symbol("airplane", .transportation),
    Symbol("bicycle", .transportation),
    Symbol("bus", .transportation),
    Symbol("cablecar", .transportation),
    Symbol("car", .transportation),
    Symbol("ferry", .transportation),
    Symbol("fuelpump", .transportation),
    Symbol("road.lanes", "road lanes", .transportation),
    Symbol("sailboat", .transportation),
    Symbol("scooter", .transportation),
    Symbol("tram", .transportation),

    //MARK: stationery
    Symbol("doc.text", "document", .stationery),
    Symbol("eraser", .stationery),
    Symbol("folder", .stationery),
    Symbol("highlighter", .stationery),
    Symbol("link", .stationery),
    Symbol("list.bullet.clipboard", "list", .stationery),
    Symbol("magnifyingglass", .stationery),
    Symbol("paperclip", .stationery),
    Symbol("pencil", .stationery),
    Symbol("pencil.and.outline", "pencil", .stationery),
    Symbol("square.and.pencil", "pencil", .stationery),
    Symbol("printer", .stationery),
    Symbol("ruler", .stationery),
    Symbol("scissors", .stationery),
    Symbol("tag", .stationery),
    Symbol("tray.full", "tray", .stationery),

    //MARK: school
    Symbol("backpack", .school),
    Symbol("bell", .school),
    Symbol("book", .school),
    Symbol("books.vertical", "books", .school),
    Symbol("studentdesk", "desk", .school),
    Symbol("graduationcap", "graduation cap", .school),
    Symbol("paperplane", .school),
    Symbol("text.book.closed", "textbook", .school),

    //MARK: tools
    Symbol("gearshape", "gear", .tools),
    Symbol("gearshape.2", "gears", .tools),
    Symbol("hammer", .tools),
    Symbol("level", .tools),
    Symbol("lock", .tools),
    Symbol("screwdriver", .tools),
    Symbol("wrench.adjustable", "wrench", .tools),

    //MARK: health
    Symbol("allergens", .health),
    Symbol("bandage", .health),
    Symbol("brain.head.profile", "brain", .health),
    Symbol("cross.case", "case", .health),
    Symbol("cross", .health),
    Symbol("waveform.path.ecg", "ecg", .health),
    Symbol("facemask", .health),
    Symbol("ivfluid.bag", "fluid bag", .health),
    Symbol("pills", .health),
    Symbol("staroflife", "star of life", .health),
    Symbol("stethoscope", .health),
    Symbol("syringe", .health),
    Symbol("testtube.2", "testtubes", .health),
    Symbol("medical.thermometer", "thermometer", .health),
    Symbol("cross.vial", "vial", .health),

    //MARK: fitness
    Symbol("figure.highintensity.intervaltraining", "HIT", .fitness),
    Symbol("figure.american.football", "american football", .fitness),
    Symbol("figure.archery", "archery", .fitness),
    Symbol("figure.australian.football", "australian football", .fitness),
    Symbol("figure.badminton", "badminton", .fitness),
    Symbol("figure.barre", "barre", .fitness),
    Symbol("baseball", .fitness),
    Symbol("figure.baseball", "baseball", .fitness),
    Symbol("basketball", .fitness),
    Symbol("figure.basketball", "basketball", .fitness),
    Symbol("figure.bowling", "bowling", .fitness),
    Symbol("figure.boxing", "boxing", .fitness),
    Symbol("figure.climbing", "climbing", .fitness),
    Symbol("figure.cooldown", "cooldown", .fitness),
    Symbol("figure.core.training", "core training", .fitness),
    Symbol("figure.cricket", "cricket", .fitness),
    Symbol("cricket.ball", "cricket ball", .fitness),
    Symbol("figure.cross.training", "cross training", .fitness),
    Symbol("figure.curling", "curling", .fitness),
    Symbol("figure.disc.sports", "disc sports", .fitness),
    Symbol("dumbbell", .fitness),
    Symbol("figure.elliptical", "elliptical", .fitness),
    Symbol("figure.equestrian.sports", "equestrian sports", .fitness),
    Symbol("figure.fencing", "fencing", .fitness),
    Symbol("figure.fishing", "fishing", .fitness),
    Symbol("flag.checkered.2.crossed", "flags", .fitness),
    Symbol("football", .fitness),
    Symbol("figure.golf", "golf", .fitness),
    Symbol("figure.handball", "handball", .fitness),
    Symbol("figure.hiking", "hiking", .fitness),
    Symbol("figure.hockey", "hockey", .fitness),
    Symbol("figure.indoor.cycle", "indoor cycle", .fitness),
    Symbol("medal", .fitness),
    Symbol("figure.outdoor.cycle", "outdoor cycle", .fitness),
    Symbol("figure.roll.runningpace", "roll", .fitness),
    Symbol("figure.run", "run", .fitness),
    Symbol("figure.skiing.downhill", "skiing", .fitness),
    Symbol("soccerball", .fitness),
    Symbol("sportscourt", .fitness),
    Symbol("figure.strengthtraining.traditional", "strength training", .fitness),
    Symbol("tennis.racket", "tennis", .fitness),
    Symbol("tennisball", .fitness),
    Symbol("trophy", .fitness),
    Symbol("figure.volleyball", "volleyball", .fitness),
    Symbol("volleyball", .fitness),
    Symbol("figure.walk", "walk", .fitness),

    //MARK: people
    Symbol("person", .people),
    Symbol("person.2", "persons", .people),
    Symbol("person.3", "persons", .people),
    Symbol("figure.roll", "roll", .people),
    Symbol("figure.stand", "stand", .people),
    Symbol("figure.walk", "walk", .people),
    Symbol("figure.wave", "wave", .people)


    
]

