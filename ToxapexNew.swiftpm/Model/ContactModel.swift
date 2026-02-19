//
//  ContactModel.swift
//  Toxapex
//
//  Created by Marco Bueno on 15/02/26.
//
import SwiftUI
import SwiftData

@Model
class ContactModel: Identifiable {
    var id = UUID()
    var name: String
    var number: String
    
    init(name: String, phone: String) {
        self.name = name
        self.number = phone
    }
}

class PrimaryContact: Identifiable {
    var id: String
    var name: String
    var number: String
    var description: String
    var image: String?
    
    init(name: String, number: String, description: String, image: String?) {
        self.id = name
        self.name = name
        self.number = number
        self.description = description
        self.image = image ?? nil
    }
}
