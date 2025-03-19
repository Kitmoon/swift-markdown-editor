//
//  SwiftDownEditorView.swift
//  markdown-editor
//
//  Created by Alexandre Le Poulichet on 19/03/2025.
//

import SwiftDown
import SwiftUI

struct SwiftDownEditorView: View {
    @State private var text: String = """
# Welcome to the Editor
This is a **markdown** editor.
## Features
- Markdown highlighting
- Simple interface
"""
    
    var body: some View {
        SwiftDownEditor(text: $text)
            .insetsSize(40)
            .theme(Theme.BuiltIn.defaultLight.theme())
    }
}

#Preview {
    SwiftDownEditorView()
}
