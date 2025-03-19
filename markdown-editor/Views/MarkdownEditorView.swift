//
//  MarkdownEditorView.swift
//  markdown-editor
//
//  Created by Alexandre Le Poulichet on 19/03/2025.
//

#Preview {
    MarkdownEditorView()
        .modelContainer(for: Item.self, inMemory: true)
}

import SwiftUI
import MarkdownUI

struct MarkdownEditorView: View {
    @State private var markdownText: String = "# Droit *Européen*" // Example text
    @State private var cursorPosition: Int? = nil // Track cursor position (optional)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Rendered Markdown with editable text
                ForEach(renderedLines.indices, id: \.self) { index in
                    HStack {
                        if index == editableLineIndex {
                            // Editable line with real-time rendering
                            ZStack(alignment: .leading) {
                                Markdown(renderedLines[index])
                                    .padding(.horizontal)
                                    .opacity(1) // Rendered Markdown in background for live preview effect
                                
                                TextField("", text: Binding(
                                    get: { renderedLines[index] },
                                    set: { newValue in updateLine(at: index, with: newValue) }
                                ))
                                .textFieldStyle(.plain)
                                .foregroundColor(.clear) // Make text transparent to show rendered Markdown
                                .background(Color.clear)
                            }
                        } else {
                            // Rendered line (non-editable)
                            Markdown(renderedLines[index])
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding()
        }
        .onTapGesture {
            determineEditableLine()
        }
    }
    
    // Split the markdown into lines for rendering and editing
    private var renderedLines: [String] {
        markdownText.components(separatedBy: "\n")
    }
    
    private var editableLineIndex: Int {
        cursorPosition ?? 0 // Default to the first line if no cursor position is set
    }
    
    private func updateLine(at index: Int, with newValue: String) {
        var lines = renderedLines
        lines[index] = newValue
        markdownText = lines.joined(separator: "\n")
    }
    
    private func determineEditableLine() {
        // Add logic to determine which line should become editable based on user interaction
        cursorPosition = 0 // Example placeholder; implement gesture-based logic here
    }
}
