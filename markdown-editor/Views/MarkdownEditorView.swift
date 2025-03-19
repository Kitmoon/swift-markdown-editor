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
    @State private var currentLineIndex: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Render lines before the current line
                ForEach(0..<currentLineIndex, id: \.self) { index in
                    Markdown { preprocessMarkdown(lines[index]) }
                        .padding(.horizontal)
                }
                
                // Editable current line
                TextEditor(text: Binding(
                    get: { lines[currentLineIndex] },
                    set: { newValue in
                        updateLine(at: currentLineIndex, with: newValue)
                    }
                ))
                .frame(height: 40) // Adjust height for single-line editing
                .border(Color.gray)
                
                // Render lines after the current line
                ForEach((currentLineIndex + 1)..<lines.count, id: \.self) { index in
                    Markdown { preprocessMarkdown(lines[index]) }
                        .padding(.horizontal)
                }
            }
        }
        .padding()
        .onAppear {
            splitMarkdownText()
        }
    }
    
    private var lines: [String] {
        markdownText.components(separatedBy: "\n")
    }
    
    private func splitMarkdownText() {
        guard !lines.isEmpty else { return }
        currentLineIndex = 0 // Start with the first line as editable
    }
    
    private func updateLine(at index: Int, with newValue: String) {
        var allLines = lines
        allLines[index] = newValue
        markdownText = allLines.joined(separator: "\n")
    }
    
    private func preprocessMarkdown(_ input: String) -> String {
        input.replacingOccurrences(of: "\n", with: "  \n") // Adds two spaces before newline for Markdown line breaks
    }
}
