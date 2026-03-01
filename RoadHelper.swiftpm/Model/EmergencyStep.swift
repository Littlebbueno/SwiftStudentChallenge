//
//  EmergencyStep.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class EmergencyStep: Identifiable {
    let id = UUID()
    var title: String
    var image: String
    var stepDescription: String
    var specificAnimation: Bool
    var insideSteps: [EmergencyStep]
    var callStep: String
    var warning: String
    var warningBefore: Bool
    var linkTo: navigationPath? = nil
    
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, linkTo: navigationPath?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = ""
        self.warningBefore = false
        self.linkTo = linkTo
    }
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, warning: String, warningBefore: Bool?, linkTo: navigationPath?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = warning
        self.warningBefore = warningBefore ?? false
        self.linkTo = linkTo
    }
    
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, warning: String, warningBefore: Bool?, linkTo: navigationPath?, callNumber : String) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = callNumber
        self.warning = warning
        self.warningBefore = warningBefore ?? false
        self.linkTo = linkTo
    }
    
    init(title: String?, text: String, callNumber: String?) {
        self.title = title ?? ""
        self.image = ""
        self.stepDescription = text
        self.specificAnimation = false
        self.insideSteps = []
        self.callStep = callNumber ?? ""
        self.warning = ""
        self.warningBefore = false
    }
    
    init(title: String?, text: String, callNumber: String?, linkTo: navigationPath) {
        self.title = title ?? ""
        self.image = ""
        self.stepDescription = text
        self.specificAnimation = false
        self.insideSteps = []
        self.callStep = callNumber ?? ""
        self.warning = ""
        self.warningBefore = false
        self.linkTo = linkTo
    }
    
    init(title: String?, text: String, callNumber: String?, image: String) {
        self.title = title ?? ""
        self.image = image
        self.stepDescription = text
        self.specificAnimation = false
        self.insideSteps = []
        self.callStep = callNumber ?? ""
        self.warning = ""
        self.warningBefore = false
    }
}
