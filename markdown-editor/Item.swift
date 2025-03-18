//
//  Item.swift
//  markdown-editor
//
//  Created by Alexandre Le Poulichet on 18/03/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
