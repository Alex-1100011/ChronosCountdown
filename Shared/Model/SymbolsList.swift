//
//  SymbolsList.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/11/22.
//

import SwiftUI

///A list of symbols, ordered alphabetically relative to the ``Symbol/displayName`` and the ``Symbol/category``
var symbols: [Symbol] = [
    
    //MARK: leisure
    Symbol("balloon.2", "balloons", .leisure),
    Symbol("beach.umbrella", "beach umbrella", .leisure),
    Symbol("binoculars", .leisure),
    Symbol("birthday.cake", "birthday cake", .leisure, kw: "food"),
    Symbol("checkerboard.rectangle", "chessboard", .leisure, kw: "game"),
    Symbol("die.face.5", "die", .leisure, kw: "game"),
    Symbol("film.stack", "film", .leisure, kw: "movie cinema theater"),
    Symbol("fireplace", .leisure),
    Symbol("gamecontroller", .leisure),
    Symbol("app.gift", "gift", .leisure, kw: "party birthday"),
    Symbol("map", .leisure),
    Symbol("building.columns", "museum", .leisure),
    Symbol("party.popper", "party popper", .leisure, kw: "birthday"),
    Symbol("popcorn", .leisure, kw: "movie cinema theater food film"),
    Symbol("puzzlepiece", .leisure, kw: "game"),
    Symbol("tent", .leisure),
    Symbol("theatermasks", "theater", .leisure, kw: "movie cinema film"),
    Symbol("ticket", .leisure, kw: "movie cinema theater film"),
    Symbol("tv.inset.filled", "tv", .leisure, kw: "movie cinema theater film"),
    Symbol("photo.on.rectangle.angled", "photos", .leisure, kw: "memories"),
    

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
    Symbol("playpause", .music),
    Symbol("opticaldisc", "CD", .music),
    Symbol("radio", .music),

    //MARK: transportation
    Symbol("airplane", .transportation),
    Symbol("airplane.arrival", "airplane landing", .transportation),
    Symbol("airplane.departure", "airplane departing", .transportation),
    Symbol("bicycle", .transportation),
    Symbol("box.truck", "truck", .transportation),
    Symbol("bus", .transportation),
    Symbol("bus.doubledecker", "double decker bus", .transportation),
    Symbol("cablecar", .transportation),
    Symbol("car", .transportation),
    Symbol("car.rear.road.lane", "road", .transportation),
    Symbol("car.side", "car", .transportation),
    Symbol("car.side.front.open.fill", "car repair", .transportation),
    Symbol("engine.combustion", "car engine",  .transportation),
    Symbol("ferry", .transportation),
    Symbol("fuelpump", .transportation),
    Symbol("oilcan", .transportation),
    Symbol("parkingsign", .transportation),
    Symbol("road.lanes", "road lanes", .transportation),
    Symbol("sailboat", .transportation),
    Symbol("scooter", .transportation),
    Symbol("steeringwheel", .transportation),
    Symbol("tram", .transportation),
    Symbol("tram.fill.tunnel", "train", .transportation),

    //MARK: nature
    Symbol("ant", .nature),
    Symbol("atom", .nature),
    Symbol("bird", .nature),
    Symbol("bolt", .nature),
    Symbol("camera.macro", "flower", .nature),
    Symbol("carrot", .nature),
    Symbol("cloud", .nature),
    Symbol("cloud.bolt", "bolt", .nature),
    Symbol("cloud.bolt.rain", "storm",  .nature),
    Symbol("cloud.moon", "cloudy night", .nature),
    Symbol("cloud.moon.bolt", "stormy night", .nature),
    Symbol("cloud.moon.rain", "rainy night", .nature),
    Symbol("cloud.rain", "rain", .nature),
    Symbol("cloud.snow", "snow", .nature),
    Symbol("cloud.sun", "cloudy day", .nature),
    Symbol("cloud.sun.rain", "rainy day", .nature),
    Symbol("fish", .nature),
    Symbol("flame", .nature),
    Symbol("fossil.shell", "shell", .nature),
    Symbol("globe.americas", "americas", .nature),
    Symbol("globe.asia.australia", "asia and australia", .nature),
    Symbol("globe.central.south.asia", "asia", .nature),
    Symbol("globe.europe.africa", "europe and africa", .nature),
    Symbol("hare", .nature),
    Symbol("ladybug", .nature),
    Symbol("laurel.leading", "laurel", .nature),
    Symbol("leaf", .nature),
    Symbol("lizard", .nature),
    Symbol("moon", .nature),
    Symbol("moon.stars", "night", .nature),
    Symbol("mountain.2", "mountains", .nature),
    Symbol("pawprint", .nature),
    Symbol("snowflake", .nature),
    Symbol("sparkles", .nature),
    Symbol("thermometer.snowflake", "cold", .nature),
    Symbol("thermometer.sun", "heat", .nature),
    Symbol("tornado", .nature),
    Symbol("tortoise", .nature),
    Symbol("tree", .nature),
    Symbol("water.waves", "water waves", .nature),
    Symbol("wind", .nature),
    Symbol("wind.snow", "cold wind", .nature),

    //MARK: objects
    Symbol("photo.artframe", "artframe", .objects, kw: "museum"),
    Symbol("bag", .objects, kw: "shopping buy"),
    Symbol("basket", .objects, kw: "shopping buy"),
    Symbol("briefcase", .objects, kw: "work"),
    Symbol("building.2", "buildings", .objects),
    Symbol("calendar", .objects, kw: "event"),
    Symbol("camera", .objects, kw: "photography"),
    Symbol("cart", .objects, kw: "shopping buy"),
    Symbol("creditcard", .objects, kw: "shopping buy"),
    Symbol("eyedropper", .objects, kw: "color design"),
    Symbol("flashlight.on.fill", "flashlight", .objects),
    Symbol("hourglass", .objects, kw: "time event"),
    Symbol("megaphone", .objects),
    Symbol("newspaper", .objects),
    Symbol("note.text", "note", .objects),
    Symbol("paintbrush", .objects, kw: "color art design"),
    Symbol("paintbrush.pointed", "paintbrush", .objects),
    Symbol("scroll", .objects),
    Symbol("suitcase", .objects, kw: "trip travel vacation"),
    Symbol("trash", .objects, kw: "delete"),
    Symbol("umbrella", .objects, kw: "weather rain"),
    Symbol("wand.and.rays", "wand", .objects, kw: "magic"),

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
    Symbol("lungs", .health),
    Symbol("eye", .health),
    Symbol("brain", .health),
    Symbol("ear", .health),
    Symbol("drop", "blood", .health),
    

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
    Symbol("x.squareroot", "squareroot", .school),
    Symbol("angle", .school),
    Symbol("compass.drawing", "compass", .school),
    Symbol("sum", "sum", .school),
    Symbol("percent", "percent", .school),
    Symbol("function", "function", .school),
    Symbol("plus.forwardslash.minus", "plus/minus", .school),

    //MARK: tools
    Symbol("gearshape", "gear", .tools),
    Symbol("gearshape.2", "gears", .tools),
    Symbol("hammer", .tools),
    Symbol("level", .tools),
    Symbol("lock", .tools),
    Symbol("key", .tools),
    Symbol("screwdriver", .tools),
    Symbol("wrench.adjustable", "wrench", .tools),

    //MARK: fitness
    Symbol("figure.highintensity.intervaltraining", "HIIT", .fitness),
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
    Symbol("figure.2.and.child.holdinghands", "family", .people),
    Symbol("figure.2.arms.open", "couple", .people),
    Symbol("figure.and.child.holdinghands", "children", .people),
    Symbol("figure.stand.line.dotted.figure.stand", "social distancing", .people),
    Symbol("hand.point.up.left", "pointing hand", .people),
    Symbol("hand.thumbsdown", "thumbsdown", .people),
    Symbol("hand.thumbsup", "thumbsup", .people),
    Symbol("person", .people),
    Symbol("person.2", "people", .people),
    Symbol("person.3", "people", .people),
    Symbol("figure.roll", "roll", .people),
    Symbol("figure.stand", "stand", .people),
    Symbol("figure.walk", "walk", .people),
    Symbol("figure.wave", "wave", .people)
]



struct SymbolsList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ForEach(symbolsCategory.allCases, id: \.self) { category in
                HStack {
                    Image(systemName: category.symbol)
                    Text(category.name)
                    Spacer()
                    
                    let filteredSymbols = symbols.filter{
                        $0.category == category
                    }
                    
                    Text(String(filteredSymbols.count))
                }
                .symbolVariant(.fill)
                .font(.title)
                .padding(.horizontal)
                
                SymbolGrid(color: .black, selectedSymbol: .constant(""), showSearch: .constant(false), category: category)
                    
            }
        }
    }
}




