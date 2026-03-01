//
//  VehicleFire.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class VehicleFire {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [EmergencyStep(
            title: "Stop & Evacuate",
            image: "",
            stepDescription: "Immediately stop the vehicle and get everyone to a safe distance.",
            specificAnimation: false,
            insideSteps: [
                EmergencyStep(title: "Secure the Car:", text: "Pull over safely away from other vehicles and turn on hazard lights.", callNumber: nil),
                EmergencyStep(title: "Cut Power:", text: "Turn off the ignition or press Start/Stop button. Remove the key to deactivate all systems.", callNumber: nil),
                EmergencyStep(title: "Evacuate:", text: "Exit now and assist others.", callNumber: nil)
            ],
            linkTo: nil
        ), EmergencyStep(title: "Fire Assessment",
                         image: "",
                         stepDescription: "Quickly assess the fire to decide if it’s possible to extinguish it yourself.",
                         specificAnimation: false,
                         insideSteps: [EmergencyStep(title: "Check the smoke:", text: "Light smoke is easier to extinguish. Thick black smoke means the fire is spreading fast.", callNumber: nil),
                        EmergencyStep(title: "Fire Size:", text: "If flames pass the hood or reach the cabin, evacuate. The fire is too large for the extinguisher.", callNumber: nil),
                        EmergencyStep(title: nil, text: "Only proceed to 'Firefighting' if the fire is manageable. Otherwise, skip it.", callNumber: nil)
            ],
                         warning: "Do NOT lift the hood up, it can worsen the fire.",
                         warningBefore: true,
                         linkTo: nil
        ),
            EmergencyStep(
                title: "Firefighting",
                image: "imageFire",
                stepDescription: "Extinguish the fire through a SMALL GAP.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Preparation:", text: "Release the hood using the interior lever and pull the extinguisher's safety pin.", callNumber: nil),
                    EmergencyStep(title: "Action:", text: "Discharge the ENTIRE extinguisher through the safety latch gap (2-3cm) or lower grille, aiming at the base of the flames.", callNumber: nil),
                    EmergencyStep(title: nil, text: "Even if flames are gone, do not restart the car.", callNumber: nil)
                    
                ],
                warning: "Do NOT lift the hood up, it can worsen the fire.",
                warningBefore: true,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Signaling and Help",
                image: "",
                stepDescription: "Signal only if safe. Protect yourself and alert other drivers.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "High Risk:", text: "Large fire? Stay away. The smoke will alert others—do NOT risk retrieving the triangle. Alert other drivers using hand signals or tree branches from a safe distance.", callNumber: nil),
                    EmergencyStep(title: "Low Risk:", text: "Small fire? Set the triangle (1 step per km/h).", callNumber: nil),
                    EmergencyStep(title: "193 (Fire Department):", text: "Call 193 if there is fire, smoke, or fuel leaks.", callNumber: "193"),
                    EmergencyStep(title: "", text: "For concessioned highways, dial the road authority's 0800 number.", callNumber: "Emergency Contacts")
                ],
                linkTo: nil
            ),
            EmergencyStep(
                title: "Fire Prevention",
                image: "",
                stepDescription: "Regular maintenance and pre-journey checks can prevent most vehicle fires.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Maintenance:", text: "Professional inspections are the best way to catch hidden risks.", callNumber: nil),
                    EmergencyStep(title: "Pre-journey Checks:", text: "Check oil, coolant, and tyre levels regularly. Refer to your manual for specific thresholds.", callNumber: nil),
                    EmergencyStep(title: "Warning Lights:", text: "Never ignore dashboard alerts. These are early indicators of electrical or mechanical failures.", callNumber: nil),
                    EmergencyStep(title: "Modifications:", text: "Ensure any modifications, especially to the electrical system (alarms/sound), are done by professionals.", callNumber: nil),
                    EmergencyStep(title: "Safety Gear:", text: "Keep a certified fire extinguisher accessible, check its pressure gauge regularly.", callNumber: nil)
                ],
                linkTo: nil
            )
        ]
    }
}
