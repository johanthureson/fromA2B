//
//  Item.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-06-06.
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
