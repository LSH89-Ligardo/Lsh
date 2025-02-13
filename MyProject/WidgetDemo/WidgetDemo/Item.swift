//
//  Item.swift
//  WidgetDemo
//
//  Created by Seonghoon Lee on 1/22/25.
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
