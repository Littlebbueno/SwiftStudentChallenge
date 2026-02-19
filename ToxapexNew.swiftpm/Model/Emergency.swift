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
    var linkTo: navigationPath? = nil
    
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, linkTo: navigationPath?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = ""
        self.warningBefore = false
        self.linkTo = linkTo
    }
    init(title: String, image: String, stepDescription: String, specificAnimation: Bool, insideSteps: [EmergencyStep]?, warning: String, warningBefore: Bool?, linkTo: navigationPath?) {
        self.title = title
        self.image = image
        self.stepDescription = stepDescription
        self.specificAnimation = specificAnimation
        self.insideSteps = insideSteps ?? []
        self.callStep = ""
        self.warning = warning
        self.warningBefore = warningBefore ?? false
        self.linkTo = linkTo
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
    
    init(title: String?, text: String, callNumber: String?, linkTo: navigationPath) {
        self.title = title ?? ""
        self.image = ""
        self.stepDescription = text
        self.specificAnimation = false
        self.insideSteps = []
        self.callStep = callNumber ?? ""
        self.warning = ""
        self.warningBefore = false
        self.linkTo = linkTo
    }
    
    init(title: String?, text: String, callNumber: String?, image: String) {
        self.title = title ?? ""
        self.image = image
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
                EmergencyStep(title: "192 (SAMU):", text: "Best for medical emergencies and victim stabilization.", callNumber: "192")
            ], linkTo: nil),
            EmergencyStep(title: "Safety First", image: "", stepDescription: "Before taking any action, ensure the area is safe for you. Do not put yourself at risk. If the scene is unstable, wait for professional emergency services.", specificAnimation: false, insideSteps: [], linkTo: nil),
            EmergencyStep(title: "Cardiac Arrest & Positioning for CPR", image: "imageCPR", stepDescription: "Only if the victim is unresponsive and NOT breathing.", specificAnimation: false, insideSteps: [EmergencyStep(title: "Positioning:", text: "Place the victim on their back on a firm surface.", callNumber: nil), EmergencyStep(title: "Your Position:", text: "Kneel beside the victim’s chest.", callNumber: nil), EmergencyStep(title: "Hand Placement:", text: "Place the heel of one hand on the center of the chest. Interlock the other hand on top.", callNumber: nil),EmergencyStep(title: nil, text: "Position your shoulders directly above your hands and lock your elbows.", callNumber: nil), EmergencyStep(title: "Compression:", text: "Press straight down (2 inches/5cm) using body weight. Let the chest recoil fully between compressions.", callNumber: nil), EmergencyStep(title: nil, text: "Go to next step to keep the rhythm of 100-120 compression per minute.", callNumber: nil)], linkTo: nil),
            EmergencyStep(title: "Perform Hands-Only CPR", image: "", stepDescription: "Keep up with the rhythm of the animation.", specificAnimation: true, insideSteps: [EmergencyStep(title: nil, text: "If possible, rotate rescuers every 2 minutes to maintain the quality of CPR.", callNumber: nil)], warning: "Do not stop until help arrives or the person starts breathing again.", warningBefore: false, linkTo: nil)
        ]
        let medicalSteps = [
            EmergencyStep(
                title: "Signaling and Safety",
                image: "",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: nil, text: "Pull over to a safe spot and turn on hazard lights.", callNumber: nil),
                    EmergencyStep(title: nil, text: "Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil)
                ],
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "Call for Help",
                image: "",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "192 (SAMU):", text: "Best for medical emergencies and victim stabilization.", callNumber: "192"),
                    EmergencyStep(title: "193 (Fire Department):", text: "If there is a fire starting or victims are trapped call 193.", callNumber: nil)
                ],
                linkTo: nil
            ),
            EmergencyStep(
                title: "What NOT to do",
                image: "",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Do Not Move the Victim:", text: "The risk of spinal cord injury is high.", callNumber: nil),
                    EmergencyStep(title: "Do Not Remove Helmets:", text: "It stabilizes the neck; removing it may cause paralysis.", callNumber: nil),
                    EmergencyStep(title: "Do Not Give Food or Water:", text: "This prevents choking and prepares them for possible surgery.", callNumber: nil)
                ],
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "Scene Safety",
                image: "",
                stepDescription: "Before taking any action, ensure the area is safe for you. Do not put yourself at risk. If the scene is unstable, wait for professional emergency services.",
                specificAnimation: false,
                insideSteps: [],
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "(X) Immediate Bleeding Control",
                image: "",
                stepDescription: "Check for massive and continuous bleeding. If none is found, proceed to the next step '(A)'.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(
                        title: "Embedded Objects:",
                        text: "Stabilize the object. Apply pressure AROUND it and use bulky dressings to keep it from moving. Avoid any pressure on the object itself.",
                        callNumber: nil
                    ),
                    EmergencyStep(
                        title: "If nothing is embedded:",
                        text: "Apply firm, direct pressure immediately. If gauze is not available, use a clean cloth.",
                        callNumber: nil
                    ),
                    EmergencyStep(title: nil, text: "Do not release pressure until the bleeding is controlled.", callNumber: nil),
                    EmergencyStep(title: nil, text: "If the compress becomes soaked with blood, place another compress on top without removing the first one.", callNumber: nil),
                    EmergencyStep(title: nil, text: "Once controlled, bandage the wound firmly using clean and soft material.", callNumber: nil)
                ],
                warning: "If there are embedded objects in the wound, DO NOT remove them.",
                warningBefore: true,
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "(A) Airway & Spinal Protection",
                image: "",
                stepDescription: "Check if the airways are clear and stabilize the cervical spine.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Stabilize:", text: "Keep head and neck aligned. Do not let them tilt or rotate. If possible, assign someone to keep the neck stable.", callNumber: nil),
//                    EmergencyStep(title: nil, text: "Use bulky cloths around the neck to stabilize it. Wrap it GENTLY.", callNumber: nil),
                    EmergencyStep(title: "Check airway:", text: "If you hear noisy breathing, coughing, or the victim cannot speak: GO to next step. If airways are clear: SKIP to '(B) Breathing'.", callNumber: nil)
                ],
                warning: "",
                warningBefore: true,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Methods to clear the Airways",
                image: "",
                stepDescription: "Attempt to clear the victim's airways using the following techniques:",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Jaw Thrust (Preferred for Trauma):", text: "Place your hands on either side of their head and use your fingertips to gently lift the angle of the jaw forward and upwards, without moving the head, to open the airway.", callNumber: nil, image: "imageCPR"),
                    EmergencyStep(title: "Chin Lift:", text: "Place one hand on the forehead and gently tilt the head back, lifting the chin with 2 fingers.", callNumber: nil, image: "imageCPR")
                ],
                warning: "If the victim is wearing a helmet, do not remove it and wait for emergency services.",
                warningBefore: true,
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "(B) Breathing & Ventilation",
                image: "",
                stepDescription: "Assess if the breathing is effective and the patient is well-oxygenated.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Watch the Chest:", text: "Does it rise and fall? Check if both sides move equally.", callNumber: nil),
                    EmergencyStep(title: "Listen:", text: "Put your ear near their mouth. Do you hear normal breathing or struggling sounds?", callNumber: nil),
                    EmergencyStep(title: "Skin Color:", text: "Check if the lips or fingers are turning blue (sign of low oxygen).", callNumber: nil),
                    EmergencyStep(title: "Monitor continuously:", text: "If breathing stops, call 192 and start CPR at the \"CPR Resuscitation\" emergency.", callNumber: nil)
                ],
                linkTo: .cpr
            ),
            
            EmergencyStep(
                title: "(C) Circulation & Bleeding",
                image: "",
                stepDescription: "Assess the victim’s blood flow and control any remaining bleeding to prevent shock.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Check Circulation:", text: "Feel for a pulse and check skin temperature; use the capillary refill test (color should return within 2 seconds).", callNumber: nil),
                    EmergencyStep(title: "Stop Bleeding:", text: "Identify and control any external bleeding.", callNumber: nil),
                    EmergencyStep(title: "Maintain Heat:", text: "Keep the victim warm with blankets or clothing to help prevent hypothermia and shock.", callNumber: nil)
                ],
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "(D & E) Neurological & Exposure",
                image: "",
                stepDescription: "Check for responsiveness and hidden injuries. Monitor until help arrives.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Mental Alertness:", text: "See if the victim is awake and knows where they are, or if they only react to voice/touch.", callNumber: nil),
                    EmergencyStep(title: "Eye Response:", text: "Check if their eyes open naturally, only when spoken to, or if they remain closed.", callNumber: nil),
                    EmergencyStep(title: "Motor Response:", text: "Observe if they can move their hands or feet when you ask them to.", callNumber: nil),
                    EmergencyStep(title: "Report to Rescuers:", text: "When help arrives, tell them your observations.", callNumber: nil)
                ],
                linkTo: nil
            )
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
                    EmergencyStep(title: "High Risk:", text: "Large fire? Stay 40m away. The smoke will alert others—do NOT risk setting the triangle.", callNumber: nil),
                    EmergencyStep(title: "Low Risk:", text: "Small fire? Set the triangle (1 step per km/h).", callNumber: nil),
                    EmergencyStep(title: "193 (Fire Department):", text: "Call 193 if there is fire, smoke, or fuel leaks.", callNumber: "193"),
                    EmergencyStep(title: "Assistance:", text: "For concessioned highways, dial the road authority's 0800 number.", callNumber: "Emergency Contacts")
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
        
        let animalHitSteps = [EmergencyStep(title: "Signaling and Safety", image: "", stepDescription: "",
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
                                        callNumber: ""
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
                                     EmergencyStep(title: "Confirm Situation:", text: "Ensure the animal is deceased and the area is properly signposted with clear traffic before stepping onto the lanes.", callNumber: nil),
                                     EmergencyStep(title: "", text: "If possible, assign someone to monitor traffic and continue signaling while you are on the road.", callNumber: nil),
                                     EmergencyStep(title: "Small Animals:", text: "Use a tool, cloth, or gloves to slide the body to the nearest shoulder. Avoid direct skin contact.", callNumber: nil),
                                     EmergencyStep(title: "Large Animals:", text: "Do not attempt to move large animals alone. Wait for highway authorities or specialized rescue.", callNumber: nil)
                                 ],
                                 warning: "NEVER touch or move a wild animal that shows any sign of life. If in doubt, go to next step and wait for rescue.",
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
                                 ], linkTo: nil
                             )
        ]

        let disabledVehicleSteps = [
            EmergencyStep(
                title: "Safety & Signaling",
                image: "",
                stepDescription: "Alert other drivers to prevent a secondary crash.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Signaling:", text: "Turn on hazard lights. Place the warning triangle at a distance equal to the speed limit (min. 30m). If unavailable, use tree branches or a flashlight from a safe distance off-road.", callNumber: nil),
                    EmergencyStep(title: "Oil Spill:", text: "Cover oil patches with sand or dirt to prevent other cars from skidding.", callNumber: nil)
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
                        title: "198 (State Highway Police):",
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
        
        let flatTireSteps = [
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
                image: "Imagem ilustrativa aplicando peso sobre o parafuso",
                stepDescription: "With the car on the ground, use the lug wrench to loosen the bolts in a counter-clockwise direction, but do not remove them completely yet.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: nil, text: "If they are stuck, use your foot to apply weight on the wrench.", callNumber: nil)], linkTo: nil
            ),

            EmergencyStep(
                title: "Lift the Car",
                image: "jack_placement",
                stepDescription: "Position the jack at the spot indicated in the manual (every car has a specific jacking point), usually near the wheel.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: nil, text: "Lift the car until the flat tire clears the ground.", callNumber: nil)], linkTo: nil
            ),

            EmergencyStep(
                title: "Swap & Safety Tip",
                image: "tire_under_car",
                stepDescription: "Remove bolts and the flat tire.",
                specificAnimation: false,
                insideSteps: [EmergencyStep(title: "Tip:", text: "SLIDE the flat tire under the car frame as a safety block.", callNumber: nil),
                             EmergencyStep(title: nil, text: "Mount the spare tire.", callNumber: nil)],
                warning: "NEVER put your body under the car while it's on the jack.",
                warningBefore: true, linkTo: nil
            ),

            EmergencyStep(
                title: "Tighten in Cross",
                image: "cross_pattern",
                stepDescription: "Tighten bolts by hand, then use the wrench in a STAR or CROSS pattern (moving to the bolt directly opposite). Do not tighten adjacent bolts in sequence.",
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
        
        let overheatingSteps = [
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
        self.immediateEmergencies = [
            Emergency(title: "Trauma Life Support", image: "cross.case.fill", steps: medicalSteps, category: 1, color: Color("Medical"), color2: Color("Medical")),
            Emergency(title: "CPR Resuscitation", image: "heart.fill", steps: cprSteps, category: 1, color: Color("CPREmergency"), color2: Color("CPREmergency2")),
            Emergency(title: "Vehicle Fire", image: "flame.fill", steps: vehicleFireSteps, category: 1, color: Color("VehicleFire"), color2: Color("VehicleFire2")),
            Emergency(title: "Animal Hit", image: "pawprint.fill", steps: animalHitSteps, category: 1, color: Color("AnimalHit"), color2: Color("AnimalHit")),
            Emergency(title: "Disabled Vehicle", image: "exclamationmark.octagon.fill", steps: disabledVehicleSteps, category: 1, color: Color("DisabledVehicle"), color2: Color("DisabledVehicle2"))
        ]
        self.vehicleEmergencies = [
            Emergency(title: "Flat Tire", image: "tire", steps: flatTireSteps, category: 2, color: Color("FlatTire"), color2: Color("FlatTire")),
            Emergency(title: "Overheating", image: "thermometer.high", steps: overheatingSteps, category: 2, color: Color("Overheating"), color2: Color("Overheating2"))]
        self.roadWeatherEmergencies = []
        
    }
}


