//
//  Item.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/29.
//  
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
