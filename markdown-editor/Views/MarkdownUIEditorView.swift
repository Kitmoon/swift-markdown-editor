//
//  MarkdownEditorView.swift
//  markdown-editor
//
//  Created by Alexandre Le Poulichet on 19/03/2025.
//

#Preview {
    MarkdownUIEditorView()
        .modelContainer(for: Item.self, inMemory: true)
}

import SwiftUI
import MarkdownUI

struct MarkdownUIEditorView: View {
    @State private var markdownText: String =
    """
# Droit *Européen*
Hello
Oui **bonjour**
""" // Example text
    @State private var editableLineIndex: Int? = nil // Track which line is editable
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Render each line as either editable (raw Markdown) or styled
                ForEach(renderedLines.indices, id: \.self) { index in
                    if index == editableLineIndex {
                        // Editable line with raw Markdown syntax visible
                        TextField("", text: Binding(
                            get: { renderedLines[index] },
                            set: { newValue in updateLine(at: index, with: newValue) }
                        ))
                        .textFieldStyle(.plain)
                        .font(.system(size: 18, weight: .regular, design: .monospaced)) // Monospaced font for raw Markdown
                        .foregroundColor(.primary)
                        .padding(4)
                        .background(Color.blue.opacity(0.1)) // Highlight background for the editable line
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            // Create a new line when Enter is pressed
                            insertNewLine(after: index)
                        }
                        // Using toolbar for exiting edit mode instead of onExitCommand
                    } else {
                        // Rendered line (non-editable)
                        Markdown(renderedLines[index])
                            .onTapGesture {
                                editableLineIndex = index // Make this line editable on tap
                                isTextFieldFocused = true
                            }
                    }
                }
            }
            .padding()
        }
        .onTapGesture {
            if editableLineIndex != nil {
                editableLineIndex = nil // Deselect the editable line on tap outside
            }
        }
        // Use toolbar items for keyboard navigation
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: moveCursorUp) {
                    Image(systemName: "arrow.up")
                }
                .disabled(editableLineIndex == nil || editableLineIndex == 0)
                
                Button(action: moveCursorDown) {
                    Image(systemName: "arrow.down")
                }
                .disabled(editableLineIndex == nil || editableLineIndex == renderedLines.count - 1)
            }
        }
    }
    
    // Split the markdown into lines for rendering and editing
    private var renderedLines: [String] {
        markdownText.components(separatedBy: "\n")
    }
    
    private func updateLine(at index: Int, with newValue: String) {
        var lines = renderedLines
        lines[index] = newValue
        markdownText = lines.joined(separator: "\n")
    }
    
    // Handle keyboard navigation
    private func moveCursorUp() {
        guard let currentIndex = editableLineIndex else { return }
        if currentIndex > 0 {
            editableLineIndex = currentIndex - 1
            isTextFieldFocused = true
        }
    }
    
    private func moveCursorDown() {
        guard let currentIndex = editableLineIndex else { return }
        if currentIndex < renderedLines.count - 1 {
            editableLineIndex = currentIndex + 1
            isTextFieldFocused = true
        }
    }
    
    // Insert a new line after the current line
    private func insertNewLine(after index: Int) {
        var lines = renderedLines
        lines.insert("", at: index + 1)
        markdownText = lines.joined(separator: "\n")
        editableLineIndex = index + 1 // Move cursor to the new line
        isTextFieldFocused = true
    }
}
