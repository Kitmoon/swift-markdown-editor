//
//  ContentView.swift
//  markdown-editor
//
//  Created by Alexandre Le Poulichet on 18/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    let useMarkdownUI: Bool
    
    var body: some View {
        VStack {
            Text("Markdown Editor")
                .font(.headline)
                .padding(.top)
            
                SwiftDownEditorView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView(useMarkdownUI: false)
        .modelContainer(for: Item.self, inMemory: true)
}
