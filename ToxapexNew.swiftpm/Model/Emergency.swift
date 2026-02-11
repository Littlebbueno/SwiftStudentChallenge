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
    var warningBefore: Bool
    
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = ""
        self.warningBefore = false
    }
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, warning: String, warningBefore: Bool?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = warning
        self.warningBefore = warningBefore ?? false
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
        let cprSteps = [
            EmergencyStep(title: "Call for Help", image: "", stepDescription: "Call the highway's 0800 number for faster assistance. If unknown, use the emergency services below:", specificAnimation: false, insideSteps: [
                EmergencyStep(title: "192 (SAMU)", text: "Best for medical emergencies and victim stabilization.", callNumber: "192")
            ]),
            EmergencyStep(title: "Cardiac Arrest & Positioning for CPR", image: "imageCPR", stepDescription: "If the victim is unresponsive and not breathing, position yourself to start Hands-Only CPR immediately.", specificAnimation: false, insideSteps: [EmergencyStep(title: nil, text: "Kneel beside the person.", callNumber: nil), EmergencyStep(title: nil, text: "Place the base of one hand in the center of your chest.", callNumber: nil), EmergencyStep(title: nil, text: "Place your other hand on top and interlace your fingers.", callNumber: nil), EmergencyStep(title: nil, text: "Position your shoulders directly above your hands.", callNumber: nil)]),
            EmergencyStep(title: "Perform Hands-Only CPR", image: "", stepDescription: "Follow the steps and keep up with the rhythm of the animation.", specificAnimation: true, insideSteps: [EmergencyStep(title: nil, text: "Press straight down 5-6 cm (2-2.5 inches) using your body weight.", callNumber: nil), EmergencyStep(title: nil, text: "Release the compression, allowing the chest to return to its original position.", callNumber: nil), EmergencyStep(title: nil, text: "If possible, rotate rescuers every 5 minutes/cycles to maintain the quality of CPR.", callNumber: nil)], warning: "Do not stop until help arrives or the person starts breathing again.", warningBefore: false)
        ]
        let medicalSteps = [
            EmergencyStep(title: "Signaling and Safety", image: "", stepDescription: "", specificAnimation: false, insideSteps: [
                EmergencyStep(title: nil, text: "Pull over to a safe spot and turn on hazard lights.", callNumber: nil),
                EmergencyStep(title: nil, text: "Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil)
            ]),
            EmergencyStep(title: "What NOT to do", image: "", stepDescription: "", specificAnimation: false, insideSteps: [EmergencyStep(title: "Do Not Move the Victim:", text: "The risk of spinal cord injury is high.", callNumber: nil), EmergencyStep(title: "Do Not Remove Helmets:", text: "Never take off a helmet. It stabilizes the neck; removing it may cause paralysis.", callNumber: nil), EmergencyStep(title: "Do Not Give Food or Water:", text: "Never offer anything to eat or drink. This prevents choking and prepares them for possible surgery.", callNumber: nil)]),
            EmergencyStep(title: "Call for Help", image: "", stepDescription: "Call the highway's 0800 number for faster assistance. If unknown, use the emergency services below:", specificAnimation: false, insideSteps: [
                EmergencyStep(title: "192 (SAMU):", text: "Best for medical emergencies and victim stabilization.", callNumber: "192"),
                EmergencyStep(title: "191 (PRF):", text: "Federal Highways (BRs). Best for crime reporting and scene safety.", callNumber: nil),
                EmergencyStep(title: "198 (PRE):", text: "State Highways. Best for official reports and traffic control.", callNumber: "Emergency Contacts")
            ]),
            EmergencyStep(title: "(X) Immediate Bleeding Control", image: "", stepDescription: "Check for massive and uncontrollable bleeding (gushing). Apply firm pressure immediately.", specificAnimation: false, insideSteps: [EmergencyStep(title: nil, text: "If compresses is not available, grab the nearest clean cloth (shirt, towel, or gauze) and press it firmly against the bleed.", callNumber: nil)], warning: "Do not release pressure until the massive bleeding is controlled.", warningBefore: false),
            EmergencyStep(title: "Cardiac Arrest & Positioning for CPR", image: "imageCPR", stepDescription: "If the victim is unresponsive and not breathing, position yourself to start Hands-Only CPR immediately.", specificAnimation: false, insideSteps: [EmergencyStep(title: nil, text: "Kneel beside the person.", callNumber: nil), EmergencyStep(title: nil, text: "Place the base of one hand in the center of your chest.", callNumber: nil), EmergencyStep(title: nil, text: "Place your other hand on top and interlace your fingers.", callNumber: nil), EmergencyStep(title: nil, text: "Position your shoulders directly above your hands.", callNumber: nil)]),
            EmergencyStep(title: "Perform Hands-Only CPR", image: "", stepDescription: "Follow the steps and keep up with the rhythm of the animation.", specificAnimation: true, insideSteps: [EmergencyStep(title: nil, text: "Press straight down 5-6 cm (2-2.5 inches) using your body weight.", callNumber: nil), EmergencyStep(title: nil, text: "Release the compression, allowing the chest to return to its original position.", callNumber: nil), EmergencyStep(title: nil, text: "If possible, rotate rescuers every 5 minutes/cycles to maintain the quality of CPR.", callNumber: nil)], warning: "Do not stop until help arrives or the person starts breathing again.", warningBefore: false),
            EmergencyStep(title: "(A) Airway & Spinal Protection", image: "", stepDescription: "Check if the airways are clear and stabilize the cervical spine.", specificAnimation: false, insideSteps: [EmergencyStep(title: nil, text: "Keep the head and neck aligned. Ideally, the entire spine should be immobilized using a backboard (long spine board).", callNumber: nil), EmergencyStep(title: "Jaw Thrust (Preferred for Trauma):", text: "Move the lower jaw forward without tilting the head back to protect the neck.", callNumber: nil), EmergencyStep(title: "Chin Lift:", text: "If there is no suspicion of spinal injury, lift the chin to open the airway.", callNumber: nil)], warning: "Do not move the victim’s neck. If they are wearing a helmet, do not remove it.", warningBefore: true),
            EmergencyStep(title: "(B) Breathing & Ventilation", image: "", stepDescription: "Assess if the breathing is effective and the patient is well-oxygenated.", specificAnimation: false, insideSteps: [
                EmergencyStep(title: "Watch the Chest:", text: "Does it rise and fall? Check if both sides move equally.", callNumber: nil), EmergencyStep(title: "Listen:", text: "Put your ear near their mouth. Do you hear normal breathing or struggling sounds?", callNumber: nil),
                EmergencyStep(title: "Skin Color:", text: "Check if the lips or fingers are turning blue (sign of low oxygen).", callNumber: nil),
                EmergencyStep(title: "Monitor continuously:", text: "If breathing stops, call 192 and start CPR at the \"Cardiac Arrest & Positioning for CPR\" step.", callNumber: nil)]),
            EmergencyStep(title: "(C) Circulation - Circulation & Bleeding", image: "", stepDescription: "Assess the victim’s blood flow and control any remaining bleeding to prevent shock.", specificAnimation: false, insideSteps: [EmergencyStep(title: "Check Circulation:", text: "Feel for a pulse and check skin temperature; use the capillary refill test (press a fingertip; color should return within 2 seconds).", callNumber: nil), EmergencyStep(title: "Stop Bleeding:", text: "Identify and control any external bleeding.", callNumber: nil), EmergencyStep(title: "Maintain Heat:", text: "Keep the victim warm with blankets or clothing to help prevent hypothermia and shock.", callNumber: nil)]),
            EmergencyStep(title: "(D & E) Neurological & Exposure", image: "", stepDescription: "Check for responsiveness and hidden injuries. Monitor until help arrives and inform them about your observations.", specificAnimation: false, insideSteps: [EmergencyStep(title: "Mental Alertness:", text: "See if the victim is awake and knows where they are, or if they only react to your voice or a gentle touch.", callNumber: nil), EmergencyStep(title: "Eye Response", text: "Check if their eyes open naturally, only when spoken to, or if they remain closed.", callNumber: nil), EmergencyStep(title: "Motor Response:", text: "Observe if they can move their hands or feet when you ask them to.", callNumber: nil)])
        ]
        
    
        let vehicleFireSteps = [EmergencyStep(
            title: "Stop & Evacuate",
            image: "",
            stepDescription: "Immediately stop the vehicle and get everyone to a safe distance.",
            specificAnimation: false,
            insideSteps: [
                EmergencyStep(title: "Secure the Car:", text: "Pull over safely away from other vehicles and turn on hazard lights.", callNumber: nil),
                EmergencyStep(title: "Cut Power:", text: "Turn off the ignition or press Start/Stop button. Remove the key to deactivate all systems.", callNumber: nil),
                EmergencyStep(title: "Evacuate:", text: "Exit now and assist others.", callNumber: nil)
            ]
        ), EmergencyStep(title: "Fire Assessment",
                         image: "",
                         stepDescription: "Quickly assess the fire to decide if it’s possible to extinguish it yourself.",
                         specificAnimation: false,
                         insideSteps: [EmergencyStep(title: "Check the smoke:", text: "Light smoke is easier to extinguish. Thick black smoke means the fire is spreading fast.", callNumber: nil),
                        EmergencyStep(title: "Fire Size:", text: "If flames pass the hood or reach the cabin, evacuate. The fire is too large for the extinguisher.", callNumber: nil),
                        EmergencyStep(title: nil, text: "Only proceed to 'Firefighting' if the fire is manageable. Otherwise, skip it.", callNumber: nil)
            ],
                         warning: "Do NOT open the hood or lift it up, it can worsen the fire.",
                         warningBefore: true
        ),
            EmergencyStep(
                title: "Firefighting",
                image: "imageFireExample",
                stepDescription: "Extinguish the fire through a SMALL GAP.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Preparation:", text: "Release the hood using the interior lever and pull the extinguisher's safety pin.", callNumber: nil),
                    EmergencyStep(title: "Action:", text: "Discharge the ENTIRE extinguisher through the safety latch gap (2-3cm) or lower grille, aiming at the base of the flames.", callNumber: nil),
                    EmergencyStep(title: nil, text: "Even if flames are gone, do not restart the car.", callNumber: nil)
                    
                ],
                warning: "Do NOT open the hood or lift it up, it can worsen the fire.",
                warningBefore: true
            ),
            EmergencyStep(
                title: "Signaling and Help",
                image: "",
                stepDescription: "Signal only if safe. Protect yourself and alert other drivers.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "High Risk:", text: "Large fire? Stay 40m away. The smoke will alert others—do NOT risk setting the triangle.", callNumber: nil),
                    EmergencyStep(title: "Low Risk:", text: "Small fire? Set the triangle (1 step per km/h).", callNumber: nil),
                    EmergencyStep(title: "193 (Fire Department):", text: "Call 193 if there is fire, smoke, or fuel leaks.", callNumber: "193"),
                    EmergencyStep(title: "Assistance:", text: "Once safe, call road assistance (0800 number) or your insurance.", callNumber: "Emergency Contacts")
                ]
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
                    EmergencyStep(title: "Safety Gear:", text: "Keep a certified fire extinguisher accessible, check its pressure gauge regularly, and learn how to use it.", callNumber: nil)
                ]
            )
        ]
        
        let animalHitStep = [EmergencyStep(title: "Signaling and Safety", image: "", stepDescription: "",
                           specificAnimation: false,
                           insideSteps: [
                               EmergencyStep(title: "", text: "Park on the shoulder BEFORE the accident site to keep your vehicle visible to others and turn on hazard lights.", callNumber: nil),
                               EmergencyStep(title: "", text: "Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil)
                           ]), EmergencyStep(
                            title: "What NOT to do",
                            image: "",
                            stepDescription: "",
                            specificAnimation: false,
                            insideSteps: [
                                EmergencyStep(title: "Do Not Touch:", text: "Alive animals may bite or kick out of fear.", callNumber: nil),
                                EmergencyStep(title: "Do Not Feed:", text: "Never give food or water. It can worsen shock or cause choking if surgery is needed.", callNumber: nil),
                                EmergencyStep(title: "No Bright Lights:", text: "Avoid shining high beams or flashlights directly into their eyes; this causes extreme stress.", callNumber: nil)
                            ]
                        ),
                             EmergencyStep(
                                 title: "Call for Help",
                                 image: "",
                                 stepDescription: "The Best Option on tolled highways: Call the Road Authority's 0800 number first. They provide the fastest response and are usually found on signs along the highway. If you can't find it, use the emergency services below.",
                                 specificAnimation: false,
                                 insideSteps: [
                                    EmergencyStep(
                                        title: "Highway Police (191):",
                                        text: "Call for accidents on Federal highways.",
                                        callNumber: ""
                                    ),

                                    EmergencyStep(
                                        title: "Environmental Military Police (190):",
                                        text: "Call for accidents on State highways.",
                                        callNumber: "Emergency Contacts"
                                    )
                                 ]
                             ),
                             EmergencyStep(
                                 title: "Moving the Animal",
                                 image: "",
                                 stepDescription: "Attempt to move the animal to the shoulder to prevent further accidents.",
                                 specificAnimation: false,
                                 insideSteps: [
                                     EmergencyStep(title: "Confirm Situation:", text: "Ensure the animal is deceased and the area is properly signposted with clear traffic before stepping onto the lanes.", callNumber: nil),
                                     EmergencyStep(title: "Small Animals:", text: "Use a tool, cloth, or gloves to slide the body to the nearest shoulder. Avoid direct skin contact.", callNumber: nil),
                                     EmergencyStep(title: "Large Animals:", text: "Do not move large carcasses alone. Ask another driver for help or wait for the authorities to arrive.", callNumber: nil)
                                 ],
                                 warning: "NEVER move an animal that shows any sign of life. If in doubt, go to next step and wait for rescue.",
                                 warningBefore: true
                             ),
                             EmergencyStep(
                                 title: "Protecting the Animal",
                                 image: "",
                                 stepDescription: "If the animal is only injured. Be its protector until help arrives.",
                                 specificAnimation: false,
                                 insideSteps: [
                                     EmergencyStep(title: "Be a Shield:", text: "Keep your hazard lights on and signal constantly to others. You are preventing a second impact.", callNumber: nil),
                                     EmergencyStep(title: "Peace and Quiet:", text: "Turn off loud music and speak softly. A calm environment is the best first aid for their shock.", callNumber: nil)
                                 ]
                             ),
                             EmergencyStep(
                                 title: "Vehicle Check-up",
                                 image: "",
                                 stepDescription: "Check for hidden damage before continuing.",
                                 specificAnimation: false,
                                 insideSteps: [
                                     EmergencyStep(title: "Leaks & Fluids:", text: "Check under the car for leaks. Do not drive if you see significant fluid loss (coolant/oil).", callNumber: nil),
                                     EmergencyStep(title: "Lights & Power:", text: "Ensure headlights and signals work. Watch for dashboard warnings or rising engine temperature for the next few kilometers.", callNumber: nil),
                                     EmergencyStep(title: "Tires & Handling:", text: "Check for flat tires and verify if the steering feels normal (not pulling to the side).", callNumber: nil),
                                     EmergencyStep(title: "Loose Parts:", text: "Make sure nothing is dragging under the car. Secure loose bumpers if possible.", callNumber: nil)
                                 ]
                             )
        ]
//        EmergencyStep(
//            title: "Rauteck Maneuver",
//            image: "imageFireExample",
//            stepDescription: "Fast extraction for unconscious passengers in immediate danger, ensuring neck stability to prevent spinal injuries.",
//            specificAnimation: false,
//            insideSteps: [
//                EmergencyStep(text: "Preparation: Unbuckle the seatbelt and free the victim's feet.", callNumber: nil),
//                EmergencyStep(text: "The Grip: Reach under the armpits and grasp the victim's forearm firmly with both hands.", callNumber: nil),
//                EmergencyStep(text: "Stabilize: Press your cheek against the victim's head to lock their neck in place.", callNumber: nil),
//                EmergencyStep(text: "Extract: Rotate them 90° and pull them out slowly, keeping their spine as straight as possible.", callNumber: nil)
//            ],
//            warning: "Only use this maneuver if there is an immediate threat to life.",
//            warningBefore: true
//        )
        
        let flatTireSteps = [
            EmergencyStep(
                title: "Safety & Signaling",
                image: "",
                stepDescription: "Park on flat, firm ground. Set to 'P' or gear, pull handbrake, and place the triangle 30m back.",
                specificAnimation: false,
                insideSteps: []
            ),

            EmergencyStep(
                title: "Locate Tools",
                image: "",
                stepDescription: "Get the jack, lug wrench, and spare tire from under the trunk floor.",
                specificAnimation: false,
                insideSteps: []
            ),

            EmergencyStep(
                title: "Loosen Bolts",
                image: "",
                stepDescription: "With the car on the ground, loosen bolts counter-clockwise. Use your body weight if they are stuck.",
                specificAnimation: false,
                insideSteps: []
            ),

            EmergencyStep(
                title: "Lift the Car",
                image: "",
                stepDescription: "Place the jack at the manual's designated spot and lift until the tire clears the ground.",
                specificAnimation: false,
                insideSteps: []
            ),

            EmergencyStep(
                title: "Swap the Tire",
                image: "",
                stepDescription: "Swap the flat for the spare. Tip: Slide the flat tire under the car frame for extra safety.",
                specificAnimation: false,
                insideSteps: [],
                warning: "NEVER place any part of your body under the vehicle while it is on the jack.",
                warningBefore: false
            ),

            EmergencyStep(
                title: "Initial Tighten",
                image: "",
                stepDescription: "Hand-tighten bolts, then use the wrench in a 'cross' pattern (tighten opposite sides).",
                specificAnimation: false,
                insideSteps: []
            ),

            EmergencyStep(
                title: "Lower & Secure",
                image: "",
                stepDescription: "Lower the car and remove the jack. Give the bolts a final, firm tighten with the wrench.",
                specificAnimation: false,
                insideSteps: []
            ),

            EmergencyStep(
                title: "Speed Limit",
                image: "",
                stepDescription: "Temporary spares have a limit (usually 80 km/h). Drive straight to a tire shop.",
                specificAnimation: false,
                insideSteps: []
            )]
        self.immediateEmergencies = [Emergency(title: "Severe Accident", image: "exclamationmark.octagon.fill", steps: medicalSteps, category: 1, color: Color("SevereAccident"), color2: Color("SevereAccident2")),
            Emergency(title: "Vehicle Fire", image: "flame.fill", steps: vehicleFireSteps, category: 1, color: Color("VehicleFire"), color2: Color("VehicleFire2")),
            Emergency(title: "Animal Hit", image: "pawprint.fill", steps: animalHitStep, category: 1, color: Color("AnimalHit"), color2: Color("AnimalHit")),
            Emergency(title: "Medical & First Aid", image: "cross.case.fill", steps: medicalSteps, category: 1, color: Color("Medical"), color2: Color("Medical")),
            Emergency(title: "CPR Resuscitation", image: "heart.fill", steps: cprSteps, category: 1, color: Color("CPREmergency"), color2: Color("CPREmergency2"))]
        self.vehicleEmergencies = [Emergency(title: "Flat Tire", image: "tire", steps: flatTireSteps, category: 2, color: Color("FlatTire"), color2: Color("FlatTire"))]
        self.roadWeatherEmergencies = []
        
    }
}


