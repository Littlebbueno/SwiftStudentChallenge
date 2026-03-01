//
//  TraumaLifeSupport.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

class TraumaLifeSupport {
    var steps: [EmergencyStep] = []
    
    init() {
        initializeSteps()
    }
    
    func initializeSteps() {
        self.steps = [
            EmergencyStep(
                title: "Signaling and Safety",
                image: "",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: nil, text: "Pull over to a safe spot and turn on hazard lights.", callNumber: nil),
                    EmergencyStep(title: nil, text: "Set the warning triangle to alert traffic and avoid secondary collisions.", callNumber: nil)
                ],
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "Call for Help",
                image: "",
                stepDescription: "Call the highway's 0800 number for faster assistance. If unknown, use the emergency services below:",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "192 (SAMU):", text: "Best for medical emergencies.", callNumber: "192"),
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
                stepDescription: "Check for massive and continuous bleeding. If none is found, proceed to step '(A)'.",
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
                    )
                ],
                warning: "If there are embedded objects in the wound, DO NOT remove them.",
                warningBefore: true,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Maintain Pressure and Elevate",
                image: "",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: nil, text: "Mantain pressure until the bleeding is controlled.", callNumber: nil),
                    EmergencyStep(title: nil, text: "If the compress becomes soaked with blood, place another compress on top without removing the first one.", callNumber: nil),
                    EmergencyStep(title: nil, text: "If possible, keep the bleeding area above heart level.", callNumber: nil)
                ],
                warning: "",
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
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "Jaw Thrust (Preferred for Trauma):", text: "Hold their face with thumbs on cheekbones and fingers under the bottom of the jaw.", callNumber: nil, image: ""),
                    EmergencyStep(title: "", text: "Use your fingertips to gently lift up on the jaw while your thumbs press down, without moving the head.", callNumber: nil, image: "imageJawThrust"),
                    EmergencyStep(title: "", text: "If the airway is still blocked, proceed to: Chin Lift.", callNumber: nil)
                ],
                warning: "If the victim is wearing a helmet, do not remove it and wait for emergency services.",
                warningBefore: true,
                linkTo: nil
            ),
            EmergencyStep(
                title: "Chin Lift",
                image: "imageChinLift",
                stepDescription: "",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "", text: "Place one hand on the forehead and gently tilt the head back, lifting the chin with 2 fingers.", callNumber: nil, image: "")
                ],
                warning: "",
                warningBefore: false,
                linkTo: nil
            ),
            
            EmergencyStep(
                title: "(B) Breathing & Ventilation",
                image: "",
                stepDescription: "Assess if the breathing is effective and the patient is well-oxygenated.",
                specificAnimation: false,
                insideSteps: [
                    EmergencyStep(title: "", text: "Look to see if their chest is rising and falling.", callNumber: nil),
                    EmergencyStep(title: "", text: "Listen over their mouth and nose for breathing sounds.", callNumber: nil),
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
                    EmergencyStep(title: "Check Circulation:", text: "Check for a pulse. Then, press down on a fingernail until the bed turns white and release; color should return within 2 seconds.", callNumber: nil, image: "imagePulse"),
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
    }
}

