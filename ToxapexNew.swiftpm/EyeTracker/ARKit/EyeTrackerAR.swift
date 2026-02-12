import ARKit
import SwiftUI
import RealityKit

@Observable
class ARFaceManager: NSObject, ARSessionDelegate {
    var eyeStatus: eyeStatus = .nofaceDetected
    
    private var blinkHistory: [Float] = []
    private let sampleLimit = 8
    
    
    let isAcessibilityOn = UserDefaults.standard.bool(forKey: "acessibilityMode")
    // false = left, true = right
    let whichEye = UserDefaults.standard.bool(forKey: "acessibilityEye")
    
    let session = ARSession()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    func start() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let config = ARFaceTrackingConfiguration()
        config.maximumNumberOfTrackedFaces = 1
        
        config.isLightEstimationEnabled = false
        session.run(config, options: [.resetTracking, .removeExistingAnchors, .stopTrackedRaycasts])
    }
    
    func stop() {
        session.pause()
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
        guard let faceAnchor = anchors.first as? ARFaceAnchor else {
            updateStatus(.nofaceDetected)
            return
        }
        
        if !faceAnchor.isTracked {
            updateStatus(.nofaceDetected)
            return
        }
        
        let blendShapes = faceAnchor.blendShapes
        if let leftBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightBlink = blendShapes[.eyeBlinkRight] as? Float {
            
            if self.isAcessibilityOn {
                if !self.whichEye {
                    blinkHistory.append(rightBlink)
                    if blinkHistory.count > sampleLimit {
                        blinkHistory.removeFirst()
                    }
                }
                else {
                    blinkHistory.append(leftBlink)
                    if blinkHistory.count > sampleLimit {
                        blinkHistory.removeFirst()
                    }
                }
            }else {
                let currentAverage = (leftBlink + rightBlink) / 2.0
                
                blinkHistory.append(currentAverage)
                if blinkHistory.count > sampleLimit {
                    blinkHistory.removeFirst()
                }
            }
            var smothedBlink: Float = 0
            for value in blinkHistory {
                smothedBlink += value
            }
            if !blinkHistory.isEmpty {
                smothedBlink = smothedBlink / Float(blinkHistory.count)
            }
            let isClosed = smothedBlink > 0.55
            updateStatus(isClosed ? .closed : .opened)
        }
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        if anchors.contains(where: { $0 is ARFaceAnchor }) {
            updateStatus(.nofaceDetected)
            blinkHistory.removeAll()
        }
    }
    
    private func updateStatus(_ newStatus: eyeStatus) {
        if self.eyeStatus != newStatus {
            self.eyeStatus = newStatus
        }
    }
}
