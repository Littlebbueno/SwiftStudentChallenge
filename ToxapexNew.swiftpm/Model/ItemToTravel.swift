//
//  ItemsToTravel.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//
import SwiftUI

class Item {
    var title: String
    var boolItem: Bool
    
    init(title: String, bool: Bool) {
        self.title = title
        self.boolItem = bool
    }
    
    init(title: String) {
        self.title = title
        self.boolItem = false
    }
}
