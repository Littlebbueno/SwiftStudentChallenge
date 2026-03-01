//
//  AnimalHit.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

class AnimalHit {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [EmergencyStep(title: "Signaling and Safety", image: "", stepDescription: "",
                                    specificAnimation: false,
                                    insideSteps: [
                                        EmergencyStep(title: "", text: "Park on the shoulder BEFORE the accident site to keep your vehicle visible to others and turn on hazard lights.", callNumber: nil),
                                        EmergencyStep(title: "", text: "Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil)
                                    ], linkTo: nil), EmergencyStep(
                                     title: "What NOT to do",
                                     image: "",
                                     stepDescription: "",
                                     specificAnimation: false,
                                     insideSteps: [
                                         EmergencyStep(title: "Do Not Touch:", text: "Alive animals may bite or kick out of fear.", callNumber: nil),
                                         EmergencyStep(title: "Do Not Feed:", text: "Never give food or water. It can worsen shock or cause choking if surgery is needed.", callNumber: nil),
                                         EmergencyStep(title: "No Bright Lights:", text: "Avoid shining high beams or flashlights directly into their eyes; this causes extreme stress.", callNumber: nil)
                                     ], linkTo: nil
                                 ),
                                      EmergencyStep(
                                          title: "Call for Help",
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
                                                 title: "Environmental Military Police (190):",
                                                 text: "Call for rescue and protection of live animals.",
                                                 callNumber: "190"
                                             ),
                                             EmergencyStep(
                                                 title: "Highway Police (191):",
                                                 text: "Call for accidents on Federal highways.",
                                                 callNumber: "Emergency Contacts"
                                             )

                                          ], linkTo: nil
                                      ),
                                      EmergencyStep(
                                          title: "Moving the Animal",
                                          image: "",
                                          stepDescription: "Attempt to move the animal to the shoulder to prevent further accidents.",
                                          specificAnimation: false,
                                          insideSteps: [
                                              EmergencyStep(title: "", text: "Ensure the animal is deceased and the area is properly signposted with clear traffic.", callNumber: nil),
                                              EmergencyStep(title: "", text: "Assign someone to monitor traffic and continue signaling while you are on the road.", callNumber: nil),
                                              EmergencyStep(title: "Small Animals:", text: "Use a tool, cloth, or gloves to slide the body to the nearest shoulder. Avoid direct skin contact.", callNumber: nil),
                                              EmergencyStep(title: "Large Animals:", text: "Do not attempt to move large animals alone. Wait for highway authorities.", callNumber: nil)
                                          ],
                                          warning: "Do not move a wild animal that shows any sign of life. If in doubt, go to next step and wait for rescue.",
                                          warningBefore: true, linkTo: nil
                                      ),
                                      EmergencyStep(
                                          title: "Protecting the Animal",
                                          image: "",
                                          stepDescription: "If the animal is only injured. Be its protector until help arrives.",
                                          specificAnimation: false,
                                          insideSteps: [
                                              EmergencyStep(title: "", text: "Keep your hazard lights on and signal constantly to others. If it's dark or foggy, use a flashlight or your phone's light to wave from a safe distance.", callNumber: nil),
                                              EmergencyStep(title: "Peace and Quiet:", text: "Turn off loud music and speak softly. A calm environment is the best first aid for their shock.", callNumber: nil)
                                          ], linkTo: nil
                                      )
                 ]
    }
}
