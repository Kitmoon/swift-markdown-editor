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
    @State private var markdownText: String =
    """
# Droit *Européen*
Hello
Oui **bonjour**
""" // Example text
    @State private var editableLineIndex: Int? = nil // Track which line is editable
    
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
                    } else {
                        // Rendered line (non-editable)
                        Markdown(renderedLines[index])
                            .onTapGesture {
                                editableLineIndex = index // Make this line editable on tap
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
}
