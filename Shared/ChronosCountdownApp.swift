//
//  ChronosCountdownApp.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI

@main
struct ChronosCountdownApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            CreateView()
                .environmentObject(dataController)
        }
    }
}
