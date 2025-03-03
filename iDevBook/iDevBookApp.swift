//
//  iDevBookApp.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/29.
//
//

import SwiftData
import SwiftUI

@main
struct iDevBookApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self, ShortCutsItem.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(
                for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
