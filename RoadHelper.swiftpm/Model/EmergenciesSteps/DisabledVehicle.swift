//
//  DisabledVehicle.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class DisabledVehicle {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [
            EmergencyStep(
                title: "Safety & Signaling",
                image: "",
                stepDescription: "Alert other drivers to prevent a secondary crash.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Signaling:", text: "Turn on hazard lights. Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil),
                    EmergencyStep(title: "Oil Spill:", text: "Cover oil patches with sand or dirt to prevent other cars from skidding.", callNumber: nil),
                    EmergencyStep(title: "", text: "Do not remain inside the vehicle on the highway, look for a safe place away of the road.", callNumber: nil)
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Fire Check",
                image: "",
                stepDescription: "In case of smoke or fire, stay away and tap below to follow the 'Vehicle Fire' protocol",
                specificAnimation: false,
                insideSteps: [
                ],
                warning: "",
                warningBefore: false,
                linkTo: .fire
            ),
            EmergencyStep(
                title: "Road Clearance",
                image: "",
                stepDescription: "If the vehicle is blocking the lane, clearing the road is the top priority.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Manual Push:", text: "If the engine can't start but wheels turn, put in Neutral (N) and push to the shoulder. Only do this if someone is monitoring traffic.", callNumber: nil),
                    EmergencyStep(title: "If moving the vehicle is impossible, go to next step.", text: "", callNumber: nil)
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "Call for help to clear the road",
                image: "",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "The BEST Option on concessioned highways:",
                        text: "Call the Road Authority's 0800 number first. They provide the fastest response and are usually found on signs along the highway.",
                        callNumber: ""
                    ),
                    EmergencyStep(
                        title: "191 (Highway Police):",
                        text: "Call for help to clear the road on Federal highways (BRs).",
                        callNumber: ""
                    ),
                    EmergencyStep(
                        title: "190 (Military Police):",
                        text: "Call for help to clear the road on State highways.",
                        callNumber: "Emergency Contacts"
                    )
                ],
                linkTo: nil
            ),
            EmergencyStep(
                title: "Keep Signaling",
                image: "",
                stepDescription: "Stay visible and alert other drivers until professional help arrives.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "",
                        text: "Keep your hazard lights ON. If it's dark or foggy, use a flashlight or your phone's light to wave from a safe distance.",
                        callNumber: nil
                    )
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            )
        ]
    }
}
