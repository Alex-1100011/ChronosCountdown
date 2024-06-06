//
//  SwiftDataPreview.swift
//  Chronos (iOS)
//
//  Created by Alessandro Alberti on 06/05/24.
//

import SwiftUI
import SwiftData

func swiftDataPreview(_ content: () -> some View) -> some View {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)
    
    return content()
        .modelContainer(container)
}
