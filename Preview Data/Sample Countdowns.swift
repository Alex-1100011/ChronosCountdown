//
//  Sample Countdowns.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 15/04/24.
//

import SwiftUI

var sampleCounters: [Counter] {
    let counter1 =
    Counter(
        name: "Trip to SF",
        date:
            Calendar.current.date(
                byAdding: .day,
                value: 24,
                to: Date()
            ) ?? Date(),
        symbolName: "airplane",
        colorHex: sampleColors[0])
    
    let counter2 =
    Counter(
        name: "Train",
        date:
            Calendar.current.date(
                byAdding: .day,
                value: 24,
                to: Date()
            ) ?? Date(),
        symbolName: "tram",
        colorHex: sampleColors[1])
    
    let counter3 =
    Counter(
        name: "Trip to Italy",
        date:
            Calendar.current.date(
                byAdding: .day,
                value: 180,
                to: Date()
            ) ?? Date(),
        symbolName: "tram",
        colorHex: sampleColors[2]
    )
    counter3.image = UIImage(named: "sperlonga")
    
    return [counter1, counter2, counter3]
}

var sampleColors: [String] = [
    "027AFF", "1DB2DF", "44D7B6",
    "35C759", "FFCC02", "FFA700", "A736FF", "E020B8",
    "E02020", "FF7100"
]
