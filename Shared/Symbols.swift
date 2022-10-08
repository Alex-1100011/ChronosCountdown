//
//  Symbols.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 08/10/22.
//
import SwiftUI

enum symbolsCategory: String, CaseIterable{
    case objects = "text.book.closed.fill"
    case transportation = "car.fill"
    case people = "person.fill"
    
    var symbol: String {
        self.rawValue
    }
    var name: String {
        String(describing: self)
    }
}

var symbols: [(name: String, category: symbolsCategory)] = [
    ("car", .transportation),
    ("tram", .transportation),
    ("cablecar.fill", .transportation),
    ("bus", .transportation),
    ("ferry", .transportation),
    ("airplane", .transportation),
    ("bicycle", .transportation),
    ("scooter", .transportation),
    ("fuelpump", .transportation),
    
    ("person", .people),
    ("person.2", .people),
    ("person.3", .people),
    
    ("figure.stand", .people),
    ("figure.wave", .people),
    ("figure.walk", .people),
    ("figure.roll", .people),
    
    ("hourglass", .objects)
]

