//
//  Emergency.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//

import SwiftUI

class Emergency: Identifiable {
    let id = UUID()
    var title: String
    var image: String
    var steps: [EmergencyStep]
    var category: Int
    var color: Color
    

    init(title: String, image: String, steps: [EmergencyStep], category: Int, color: Color) {
        self.title = title
        self.image = image
        self.steps = steps
        self.category = category
        self.color = color
    }
}

class EmergencyStep: Identifiable {
    let id = UUID()
    var title: String
    var image: String 
    var stepDescription: String
    var specificAnimation: Bool
    
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
    }
}

@Observable
class EmergencyManager {
    var immediateEmergencies: [Emergency] = []

    var roadWeatherEmergencies: [Emergency] = []

    var vehicleEmergencies: [Emergency] = []
    
    init(){
        loadEmergencies()
    }
    
    func loadEmergencies(){
        let medicalSteps = [
            EmergencyStep(title: "Signaling", image: "exclamationmark.triangle.fill", stepDescription: "Pull over to a safe spot and turn on hazard lights. Place the warning triangle 30m away, or 110m on highways.", specificAnimation: false),
            EmergencyStep(title: "Call for Help", image: "phone.circle.fill", stepDescription: "Call 192 (SAMU) or 191 (PRF). If available, call the highway toll operator (0800).", specificAnimation: false),
            EmergencyStep(title: "X: Bleeding & CPR", image: "heart.fill", stepDescription: "Apply firm pressure to heavy bleeding. If victim is not breathing, start CPR: 100-120 compressions/min.", specificAnimation: true),
            EmergencyStep(title: "A: Airway & Cervical", image: "person.fill.viewfinder", stepDescription: "Keep neck immobile. Slightly lift the chin to open the airway. NEVER remove a helmet.", specificAnimation: false),
            EmergencyStep(title: "B/C: General Check", image: "lungs.fill", stepDescription: "Watch for chest movement. Press a fingertip (color should return in 2s). Keep the victim warm.", specificAnimation: false),
            EmergencyStep(title: "D/E: Final Assessment", image: "eye.fill", stepDescription: "Check for responsiveness and hidden injuries. Monitor breathing until help arrives.", specificAnimation: false),
            EmergencyStep(title: "What NOT to do", image: "xmark.octagon.fill", stepDescription: "Do not move the victim. Do not give food or water. Do not leave them alone.", specificAnimation: false)
        ]
        self.immediateEmergencies = [Emergency(title: "Severe Accident", image: "exclamationmark.octagon.fill", steps: medicalSteps, category: 1, color: Color("SevereAccident")), Emergency(title: "Animal Hit", image: "pawprint.fill", steps: medicalSteps, category: 1, color: Color("AnimalHit")), Emergency(title: "Vehicle Fire", image: "flame.fill", steps: medicalSteps, category: 1, color: Color("VehicleFire")), Emergency(title: "Medical", image: "cross.case.fill", steps: medicalSteps, category: 1, color: Color("Medical"))]
        self.vehicleEmergencies = [Emergency(title: "Flat Tire", image: "tire", steps: medicalSteps, category: 2, color: Color("FlatTire"))]
        self.roadWeatherEmergencies = []
        
    }
}


