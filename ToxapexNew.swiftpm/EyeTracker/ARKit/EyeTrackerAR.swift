//
//  EyeTrackerAR.swift
//  Toxapex
//
//  Created by Marco Bueno on 02/02/26.
//

import ARKit
import SwiftUI

@Observable
class ARFaceManager: NSObject, ARSessionDelegate {
    var eyesClosed = false
    var isFaceDetected = false
    
    let session = ARSession()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    func start() {
        guard ARFaceTrackingConfiguration.isSupported else {
            print("ARKit Face Tracking não suportado neste hardware.")
            return
        }
        
        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func stop() {
        session.pause()
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.first as? ARFaceAnchor else {
            if isFaceDetected { isFaceDetected = false }
            return
        }
        
        isFaceDetected = faceAnchor.isTracked
        
        let blendShapes = faceAnchor.blendShapes
        if let leftBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightBlink = blendShapes[.eyeBlinkRight] as? Float {
            
            let closed = (leftBlink > 0.6 && rightBlink > 0.6)
            
            if self.eyesClosed != closed {
                self.eyesClosed = closed
            }
        }
    }
}
