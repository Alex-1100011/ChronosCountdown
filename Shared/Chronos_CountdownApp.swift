//
//  Chronos_CountdownApp.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI

@main
struct Chronos_CountdownApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
