//
//  Overheating.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class Overheating {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [
            EmergencyStep(
                title: "Identification",
                image: "",
                stepDescription: "The first sign is usually the warning light on the dashboard. However, if the sensor fails, watch for these other signs:",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "Coolant Leak:",
                        text: "Reddish or bluish fluid leaking onto the ground under the engine.",
                        callNumber: nil
                    ),
                    EmergencyStep(
                        title: "Radiator Fan:",
                        text: "The radiator fan running loudly, or for an unusually long time.",
                        callNumber: nil
                    ),
                    EmergencyStep(
                        title: "Steam or Smoke:",
                        text: "Steam or smoke coming from under the hood – critical situation.",
                        callNumber: nil
                    )
                ],
                warning: "If you notice any of these signs while driving, pull over immediately to a safe location and shut off the engine.",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Waiting & Signaling",
                image: "",
                stepDescription: "Wait at least 40 minutes before checking the coolant level. This is the necessary time for the system to depressurize and cool down.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "Safety First:",
                        text: "Place the warning triangle at least 30m behind the car and keep your hazard lights ON.",
                        callNumber: nil
                    )
                ],
                warning: "Do not touch the hood while the engine is hot.",
                warningBefore: true,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Locating the System",
                image: "",
                stepDescription: "The radiator usually is located at the very front of the engine, behind the grille.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "",
                        text: "Look for a translucent plastic reservoir with a colored liquid (pink, blue, or green).",
                        callNumber: nil
                    ),
                    EmergencyStep(
                        title: "",
                        text: "The cap will usually have a warning symbol: 'Never open when hot'.",
                        callNumber: nil
                    ),
                    EmergencyStep(title: "", text: "If you cannot find it, check your vehicle's manual.", callNumber: nil)
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Refilling the Coolant",
                image: "",
                stepDescription: "If the coolant level is low, you must refill it carefully to avoid engine damage.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "",
                        text: "With the engine ON and idling, slowly pour water or coolant into the reservoir. This prevents thermal shock.",
                        callNumber: nil
                    )
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Professional Inspection",
                image: "",
                stepDescription: "A low coolant level always indicates a problem. Even if the car seems fine now, you must take action.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "",
                        text: "Go to a repair shop as soon as possible to find the cause of the leak or overheat.",
                        callNumber: nil
                    ),
                    EmergencyStep(
                        title: "System Flush:",
                        text: "Ask the mechanic to replace the temporary water with the proper coolant additive to prevent future overheating.",
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
