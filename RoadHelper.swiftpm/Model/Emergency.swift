//
//  Emergency.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//

import SwiftUI

class URLLink: Identifiable {
    let id = UUID()
    var title: String
    var url: String
    
    init(title: String, url: String){
        self.title = title
        self.url = url
    }
}

class Emergency: Identifiable {
    let id = UUID()
    var title: String
    var image: String
    var steps: [EmergencyStep]
    var category: Int
    var color: Color
    var color2: Color
    var links: [URLLink]
    

    init(title: String, image: String, steps: [EmergencyStep], category: Int, color: Color, color2: Color, links: [URLLink]) {
        self.title = title
        self.image = image
        self.steps = steps
        self.category = category
        self.color = color
        self.color2 = color2
        self.links = links
    }
}


