//
//  SafelyMove.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class SafelyMove {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [
            EmergencyStep(
                title: "When to Move the Victim",
                image: "",
                stepDescription: "Only move a victim if their current location poses an immediate threat to their life. In all other cases, DO NOT move the victim and call 192.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Immediate danger:", text: "Such as fire, vehicle submersion, or structural collapse.", callNumber: nil),
                    EmergencyStep(title: "CPR:", text: "To perform life-saving CPR (requires a firm, flat surface).", callNumber: nil),
                    EmergencyStep(title: "Extreme Isolation:", text: "When it is certain that emergency help cannot reach the location.", callNumber: nil)
                ],
                warning: "Moving a victim incorrectly can severely worsen their condition.",
                warningBefore: true,
                linkTo: nil,
                callNumber: "192"
            ),
            EmergencyStep(
                title: "Prepare the Victim",
                image: "",
                stepDescription: "Before moving, assess the victim's consciousness and ensure your own safety first.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Communicate:", text: "If the victim is conscious, explain what you are going to do and ask for their cooperation.", callNumber: nil),
                    EmergencyStep(title: "", text: "Support the neck and avoid twisting the head or body during movement.", callNumber: nil)
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Climate Protection",
                image: "",
                stepDescription: "Shield the casualty from extreme cold or heat while waiting for help or preparing to move.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Against Cold:", text: "Cover with a coat, blanket, or insulation blanket.", callNumber: nil),
                    EmergencyStep(title: "Against Heat:", text: "Improvise a sunshade with an umbrella or use your own shadow to cover them.", callNumber: nil),
                    EmergencyStep(title: "Moving for Exposure:", text: "Only move them if they face real risk due to long-time exposure to cold.", callNumber: nil)
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Positioning for Removal",
                image: "",
                stepDescription: "Follow these steps to bring an unconscious victim to a lifting position safely. This technique is known as Rauteck Maneuver.",
                specificAnimation: true,
                insideSteps: [
                    EmergencyStep(title: "", text: "Lay the victim’s arms along their body.", callNumber: nil),
                    EmergencyStep(title: "", text: "Kneel behind their head. Slide one hand under their neck and the other between their shoulder blades.", callNumber: nil),
                    EmergencyStep(title: "", text: "Carefully lift their head and shoulders and slide yourself closer.", callNumber: nil),
                    EmergencyStep(title: "", text: "Raise the victim's back to bring them to a sitting position. Support their shoulders.", callNumber: nil)
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Executing the Drag",
                image: "imageRauteck",
                stepDescription: "",
                specificAnimation: true,
                insideSteps: [
                    EmergencyStep(
                        title: "The Grip and Support",
                        text: "Reach under the armpits. If the victim is heavy, grip one forearm with both hands. If you can manage the weight, use one hand to support the chin/neck while the other grips the forearm.",
                        callNumber: nil
                    ),
                    EmergencyStep(title: "", text: "Crouch with the victim between your legs, keep your back straight, and stand up.", callNumber: nil),
                    EmergencyStep(title: "", text: "Walk backward, trailing the victim with you, while watching for obstacles behind.", callNumber: nil)
                ],
                warning: "Do not let go of the victim's arm until you reach a secure area.",
                warningBefore: false,
                linkTo: nil
            )
        ]
    }
}
