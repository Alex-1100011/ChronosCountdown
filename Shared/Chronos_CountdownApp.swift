//
//  Chronos_CountdownApp.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI

@main
struct Chronos_CountdownApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
