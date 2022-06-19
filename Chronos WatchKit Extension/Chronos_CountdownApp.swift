//
//  Chronos_CountdownApp.swift
//  Chronos WatchKit Extension
//
//  Created by Alessandro Alberti on 19/06/22.
//

import SwiftUI

@main
struct Chronos_CountdownApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(counters: [])
            }
        }
    }
}
