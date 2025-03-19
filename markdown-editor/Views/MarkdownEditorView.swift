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
    @State private var markdownText: String = "# Hello, World!\nThis is **Markdown**."
    @State private var cursorPosition: Int? = nil // Track cursor position
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Render each line as either editable or rendered
                ForEach(renderedLines.indices, id: \.self) { index in
                    if index == editableLineIndex {
                        // Editable line
                        TextField("", text: Binding(
                            get: { renderedLines[index] },
                            set: { newValue in updateLine(at: index, with: newValue) }
                        ))
                        .textFieldStyle(.roundedBorder)
                        .onTapGesture {
                            cursorPosition = index // Set the tapped line as editable
                        }
                    } else {
                        // Rendered line
                        Markdown(renderedLines[index])
                            .padding(.horizontal)
                            .onTapGesture {
                                cursorPosition = index // Set the tapped line as editable
                            }
                    }
                }
            }
            .padding()
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
}
