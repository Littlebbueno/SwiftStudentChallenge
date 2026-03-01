//
//  FlatTire.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class FlatTire {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [
            EmergencyStep(
                title: "Safety & Signaling",
                image: "",
                stepDescription: "Park on safe, flat ground.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: nil, text: "Turn on your car's hazard lights", callNumber: nil),
                    EmergencyStep(title: nil, text: "Set to 'P' (Automatic) or 1st Gear (Manual) and pull the handbrake.", callNumber: nil),
                EmergencyStep(title: nil, text: "Place the warning triangle 30m behind the car.", callNumber: nil)], linkTo: nil
            ),
            EmergencyStep(title: "Tools", image: "", stepDescription: "Find the jack, lug wrench, and spare tire.", specificAnimation: false, insideSteps: [EmergencyStep(title: nil, text: "Typically they are stored beneath the trunk floorboard.", callNumber: nil)], linkTo: nil),
            EmergencyStep(
                title: "Loosen Bolts",
                image: "",
                stepDescription: "With the car on the ground, use the lug wrench to loosen the bolts in a counter-clockwise direction, but do not remove them completely yet.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: nil, text: "If they are stuck, use your foot to apply weight on the wrench.", callNumber: nil)], linkTo: nil
            ),

            EmergencyStep(
                title: "Lift the Car",
                image: "imageLiftingCar",
                stepDescription: "Position the jack at the spot indicated in the manual (every car has a specific jacking point), usually near the wheel.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: nil, text: "Lift the car until the flat tire clears the ground.", callNumber: nil)], linkTo: nil
            ),

            EmergencyStep(
                title: "Swap & Safety Tip",
                image: "",
                stepDescription: "Remove bolts and the flat tire.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: "Tip:", text: "SLIDE the flat tire under the car frame as a safety block.", callNumber: nil),
                             EmergencyStep(title: nil, text: "Mount the spare tire.", callNumber: nil)],
                warning: "NEVER put your body under the car while it's on the jack.",
                warningBefore: true, linkTo: nil
            ),

            EmergencyStep(
                title: "Tighten in Cross",
                image: "",
                stepDescription: "Tighten bolts by hand, then use the wrench in a STAR or CROSS pattern. Do not tighten adjacent bolts in sequence.",
                specificAnimation: false,
                insideSteps: [], linkTo: nil
            ),

            EmergencyStep(
                title: "Final Check",
                image: "",
                stepDescription: "Lower the car, remove the jack and the tire from underneath.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: "Final tightening:", text: "Tighten bolts firmly one last time.", callNumber: nil)],
                warning: "Temporary spares are limited to 80 km/h. Avoid high speeds and replace the tire immediately.",
                warningBefore: false, linkTo: nil
            )
        ]
    }
}
