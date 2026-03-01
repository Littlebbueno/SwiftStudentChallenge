//
//  CPR_Resuscitation.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//
import SwiftUI

class CPRResuscitation {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [
            EmergencyStep(title: "Call for Help", image: "", stepDescription: "Call the highway's 0800 number for faster assistance. If unknown, use the emergency service below:", specificAnimation: false, insideSteps: [
                EmergencyStep(title: "192 (SAMU):", text: "Best for medical emergencies and victim stabilization.", callNumber: "192")
            ], linkTo: nil),
            EmergencyStep(title: "Safety First", image: "", stepDescription: "Before taking any action, ensure the area is safe for you. Do not put yourself at risk. If the scene is unstable, wait for professional emergency services.", specificAnimation: false, insideSteps: [], linkTo: nil),
            EmergencyStep(
                title: "Firm Surface",
                image: "",
                stepDescription: "Place the victim on their back on a firm, flat surface (such as the ground).",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "If moving is necessary:",
                        text: "Keep the head, neck, and back aligned. Avoid twisting the body at all costs to prevent spinal damage.",
                        callNumber: nil
                    ),
                    EmergencyStep(
                        title: "",
                        text: "For more details on how to move someone safely, see 'Safely Moving a Victim'.",
                        callNumber: nil
                    ),
                ],
                warning: "",
                warningBefore: false,
                linkTo: .moveVictim
            ),
            EmergencyStep(title: "Positioning for CPR", image: "imageCPR", stepDescription: "Only if the victim is unresponsive and NOT breathing.", specificAnimation: false, insideSteps: [ EmergencyStep(title: "", text: "Kneel beside the victim’s chest.", callNumber: nil), EmergencyStep(title: "Hand Placement:", text: "Place the heel of one hand on the center of the chest. Interlock the other hand on top.", callNumber: nil),EmergencyStep(title: nil, text: "Position your shoulders directly above your hands and lock your elbows.", callNumber: nil), EmergencyStep(title: "Compression:", text: "Press straight down (2 inches/5cm) using body weight. Let the chest recoil fully between compressions.", callNumber: nil), EmergencyStep(title: nil, text: "Go to next step to keep the rhythm of 100-120 compression per minute.", callNumber: nil)], linkTo: nil),
            EmergencyStep(title: "Perform Hands-Only CPR", image: "", stepDescription: "Keep up with the rhythm of the animation.", specificAnimation: true, insideSteps: [EmergencyStep(title: nil, text: "If possible, rotate rescuers every 2 minutes to maintain the quality of CPR.", callNumber: nil)], warning: "Do not stop until help arrives or the person starts breathing again.", warningBefore: false, linkTo: nil)
        ]
    }
}
