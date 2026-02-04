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
    var color2: Color
    

    init(title: String, image: String, steps: [EmergencyStep], category: Int, color: Color, color2: Color) {
        self.title = title
        self.image = image
        self.steps = steps
        self.category = category
        self.color = color
        self.color2 = color2
    }
}

class EmergencyStep: Identifiable {
    let id = UUID()
    var title: String
    var image: String 
    var stepDescription: String
    var specificAnimation: Bool
    var insideSteps: [EmergencyStep]
    var callStep: String
    var warning: String
    
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = ""
    }
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, warning: String) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = warning
    }
    init(text: String, callNumber: String?) {
        self.title = ""
        self.image = ""
        self.stepDescription = text
        self.specificAnimation = false
        self.insideSteps = []
        self.callStep = callNumber ?? ""
        self.warning = ""
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
            EmergencyStep(title: "Signaling and Safety", image: "", stepDescription: "", specificAnimation: false, insideSteps: [
                EmergencyStep(text: "Pull over to a safe spot and turn on hazard lights.", callNumber: nil),
                EmergencyStep(text: "Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil)
            ]),
            EmergencyStep(title: "Call for Help", image: "", stepDescription: "Call the highway's 0800 number for faster assistance. If unknown, use the emergency services below:", specificAnimation: false, insideSteps: [
                EmergencyStep(text: "192 (SAMU): Best for medical emergencies and victim stabilization.", callNumber: "192"),
                EmergencyStep(text: "191 (PRF): Federal Highways (BRs). Best for crime reporting and scene safety.", callNumber: nil),
                EmergencyStep(text: "198 (PRE): State Highways. Best for official reports and traffic control.", callNumber: nil)
            ]),
            EmergencyStep(title: "Immediate Bleeding Control (X)", image: "", stepDescription: "Check for massive and uncontrollable bleeding (gushing). Apply firm pressure immediately.", specificAnimation: false, insideSteps: nil, warning: "Do not release pressure until the massive bleeding is controlled."),
            EmergencyStep(title: "Cardiac Arrest & Positioning for CPR", image: "imageCPRExample", stepDescription: "If the victim is unresponsive and not breathing, position yourself to start Hands-Only CPR immediately.", specificAnimation: false, insideSteps: [EmergencyStep(text: "Kneel beside the person.", callNumber: nil), EmergencyStep(text: "Place the base of one hand in the center of your chest.", callNumber: nil), EmergencyStep(text: "Place your other hand on top and interlace your fingers.", callNumber: nil), EmergencyStep(text: "Position your shoulders directly above your hands.", callNumber: nil)]),
            EmergencyStep(title: "Perform Hands-Only CPR", image: "", stepDescription: "Follow the steps and keep up with the rhythm of the animation.", specificAnimation: true, insideSteps: [EmergencyStep(text: "Press straight down 5-6 cm (2-2.5 inches) using your body weight.", callNumber: nil), EmergencyStep(text: "Release the compression, allowing the chest to return to its original position.", callNumber: nil), EmergencyStep(text: "If possible, rotate rescuers every 5 minutes/cycles to maintain the quality of CPR.", callNumber: nil)]),
            EmergencyStep(title: "A: Airway & Cervical", image: "imageFireExample", stepDescription: "Keep neck immobile. Slightly lift the chin to open the airway. NEVER remove a helmet.", specificAnimation: false, insideSteps: nil),
            EmergencyStep(title: "B/C: General Check", image: "", stepDescription: "Watch for chest movement. Press a fingertip (color should return in 2s). Keep the victim warm.", specificAnimation: false, insideSteps: nil),
            EmergencyStep(title: "D/E: Final Assessment", image: "", stepDescription: "Check for responsiveness and hidden injuries. Monitor breathing until help arrives.", specificAnimation: false, insideSteps: nil),
            EmergencyStep(title: "What NOT to do", image: "", stepDescription: "Do not move the victim. Do not give food or water. Do not leave them alone.", specificAnimation: false, insideSteps: nil)
        ]
        self.immediateEmergencies = [Emergency(title: "Severe Accident", image: "exclamationmark.octagon.fill", steps: medicalSteps, category: 1, color: Color("SevereAccident"), color2: Color("SevereAccident2")), Emergency(title: "Animal Hit", image: "pawprint.fill", steps: medicalSteps, category: 1, color: Color("AnimalHit"), color2: Color("AnimalHit")), Emergency(title: "Vehicle Fire", image: "flame.fill", steps: medicalSteps, category: 1, color: Color("VehicleFire"), color2: Color("VehicleFire2")), Emergency(title: "Medical & First Aid", image: "cross.case.fill", steps: medicalSteps, category: 1, color: Color("Medical"), color2: Color("Medical"))]
        self.vehicleEmergencies = [Emergency(title: "Flat Tire", image: "tire", steps: medicalSteps, category: 2, color: Color("FlatTire"), color2: Color("FlatTire"))]
        self.roadWeatherEmergencies = []
        
    }
}


