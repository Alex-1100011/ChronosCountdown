//
//  Symbols.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//
import SwiftUI

enum symbolsCategory: String, CaseIterable{
    case health = "stethoscope"
    case objects = "text.book.closed.fill"
    case music = "music.note"
    case transportation = "car.fill"
    case people = "person.fill"
    case fitness = "figure.run"
    
    var symbol: String {
        self.rawValue
    }
    var name: String {
        String(describing: self)
    }
}

var symbols: [(name: String, category: symbolsCategory)] = [
    
    //MARK: Transportation
    ("car", .transportation),
    ("tram", .transportation),
    ("cablecar", .transportation),
    ("bus", .transportation),
    ("ferry", .transportation),
    ("airplane", .transportation),
    ("bicycle", .transportation),
    ("scooter", .transportation),
    ("fuelpump", .transportation),
    
    //MARK: People
    ("person", .people),
    ("person.2", .people),
    ("person.3", .people),
    ("figure.stand", .people),
    ("figure.wave", .people),
    ("figure.walk", .people),
    ("figure.roll", .people),
    
    //MARK: Music
    ("music.note", .music),
    ("music.mic", .music),
    ("music.quarternote.3", .music),
    ("guitars", .music),
    ("pianokeys", .music),
    ("headphones", .music),
    ("mic.fill", .music),
    ("earbuds", .music),
    ("hifispeaker", .music),
    ("speaker.wave.2", .music),
    ("hifispeaker.2", .music),
    ("dial.low", .music),
    ("metronome", .music),
    ("tuningfork", .music),
    ("amplifier", .music),
    
    //MARK: Fitness
    ("sportscourt", .fitness),
    ("dumbbell", .fitness),
    ("soccerball", .fitness),
    ("baseball", .fitness),
    ("basketball", .fitness),
    ("football", .fitness),
    ("cricket.ball", .fitness),
    ("tennisball", .fitness),
    ("volleyball", .fitness),
    ("tennis.racket", .fitness),
    ("trophy", .fitness),
    ("medal", .fitness),
    ("flag.checkered.2.crossed", .fitness),
    ("figure.walk", .fitness),
    ("figure.run", .fitness),
    ("figure.roll.runningpace", .fitness),
    ("figure.american.football", .fitness),
    ("figure.archery", .fitness),
    ("figure.australian.football", .fitness),
    ("figure.badminton", .fitness),
    ("figure.barre", .fitness),
    ("figure.baseball", .fitness),
    ("figure.basketball", .fitness),
    ("figure.bowling", .fitness),
    ("figure.boxing", .fitness),
    ("figure.climbing", .fitness),
    ("figure.cooldown", .fitness),
    ("figure.core.training", .fitness),
    ("figure.cricket", .fitness),
    ("figure.skiing.downhill", .fitness),
    ("figure.cross.training", .fitness),
    ("figure.curling", .fitness),
    ("figure.disc.sports", .fitness),
    ("figure.elliptical", .fitness),
    ("figure.equestrian.sports", .fitness),
    ("figure.fencing", .fitness),
    ("figure.fishing", .fitness),
    ("figure.golf", .fitness),
    ("figure.handball", .fitness),
    ("figure.highintensity.intervaltraining", .fitness),
    ("figure.hiking", .fitness),
    ("figure.hockey", .fitness),
    ("figure.indoor.cycle", .fitness),
    ("figure.outdoor.cycle", .fitness),
    ("figure.strengthtraining.traditional", .fitness),
    ("figure.volleyball", .fitness),
    
    //MARK: Health
    ("cross.case", .health),
    ("medical.thermometer", .health),
    ("bandage", .health),
    ("syringe", .health),
    ("facemask", .health),
    ("pills", .health),
    ("cross", .health),
    ("cross.vial", .health),
    ("ivfluid.bag", .health),
    ("staroflife", .health),
    ("allergens", .health),
    ("waveform.path.ecg", .health),
    ("brain.head.profile", .health),
    ("testtube.2", .health),
    ("stethoscope", .health),
    
    //MARK: Objects
    ("hourglass", .objects),
    ("pencil", .objects),
    ("eraser", .objects),
    ("square.and.pencil", .objects),
    ("highlighter", .objects),
    ("pencil.and.outline", .objects),
    ("trash", .objects),
    ("folder", .objects),
    ("paperplane", .objects),
    ("tray.full", .objects),
    ("doc.text", .objects),
    ("list.bullet.clipboard", .objects),
    ("note.text", .objects),
    ("calendar", .objects),
    ("book", .objects),
    ("books.vertical", .objects),
    ("text.book.closed", .objects),
    ("newspaper", .objects),
    ("graduationcap", .objects),
    ("ruler", .objects),
    ("backpack", .objects),
    ("studentdesk", .objects),
    ("paperclip", .objects),
    ("link", .objects),
    ("photo.artframe", .objects),
    ("beach.umbrella", .objects),
    ("umbrella", .objects),
    ("megaphone", .objects),
    ("magnifyingglass", .objects),
    ("bell", .objects),
    ("tag", .objects),
    ("flashlight.on.fill", .objects),
    ("camera", .objects),
    ("gearshape", .objects),
    ("gearshape.2", .objects),
    ("scissors", .objects),
    ("bag", .objects),
    ("cart", .objects),
    ("basket", .objects),
    ("creditcard", .objects),
    ("wand.and.rays", .objects),
    ("creditcard", .objects),
    ("die.face.5", .objects),
    ("paintbrush", .objects),
    ("paintbrush.pointed", .objects),
    ("level", .objects),
    ("wrench.adjustable", .objects),
    ("hammer", .objects),
    ("screwdriver", .objects),
    ("eyedropper", .objects),
    ("scroll", .objects),
    ("printer", .objects),
    ("briefcase", .objects),
    ("suitcase", .objects),
    ("puzzlepiece.fill", .objects),
    ("balloon.2", .objects),
    ("tent", .objects),
    ("building.2", .objects),
    ("lock", .objects),
    ("map", .objects)
]

