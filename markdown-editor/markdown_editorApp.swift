//
//  markdown_editorApp.swift
//  markdown-editor
//
//  Created by Alexandre Le Poulichet on 18/03/2025.
//

import SwiftUI
import SwiftData

@main
struct markdown_editorApp: App {
    // Use this to toggle between different editor implementations
    // Change to true to use MarkdownUI, false to use SwiftDown
    private let useMarkdownUI = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(useMarkdownUI: useMarkdownUI)
        }
        .modelContainer(sharedModelContainer)
    }
}
