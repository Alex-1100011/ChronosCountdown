//
//  Sample Countdowns.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 15/04/24.
//

import SwiftUI

var sampleCounters: [Counter] = [
    Counter(
        name: "Trip to SF",
        date:
            Calendar.current.date(
                byAdding: .day,
                value: 24,
                to: Date()
            ) ?? Date(),
        color: sampleColors[0],
        symbolName: "airplane"),
    Counter(
        name: "Train",
        date:
            Calendar.current.date(
                byAdding: .day,
                value: 24,
                to: Date()
            ) ?? Date(),
        color: sampleColors[1],
        symbolName: "tram"),
    Counter(
        name: "Trip to Italy",
        date:
            Calendar.current.date(
                byAdding: .day,
                value: 180,
                to: Date()
            ) ?? Date(),
        color: sampleColors[2],
        symbolName: "tram",
        image: UIImage(named: "sperlonga")
        )
]

var sampleColors: [Color] = [
    Color(hex: "027AFF"), Color(hex: "1DB2DF"), Color(hex: "44D7B6"),
    Color(hex: "35C759"), Color(hex: "FFCC02"), Color(hex: "FFA700"), Color(hex: "A736FF"), Color(hex: "E020B8"),
    Color(hex: "E02020"), Color(hex: "FF7100")
]
