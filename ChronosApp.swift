//
//  ChronosApp.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI

@main
struct ChronosApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Counter.self)
    }
}
