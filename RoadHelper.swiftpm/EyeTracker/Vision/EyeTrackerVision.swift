//
//  EyeTrackerVision.swift
//  RoadHelper
//
//  Created by Marco Bueno on 15/01/26.
//
import Vision
import UIKit
import SwiftUI

enum eyeStatus {
    case opened
    case closed
    case nofaceDetected
}


@Observable
class EyeTracker{
    var eyeStatus: eyeStatus = .nofaceDetected
    
    var isAcessibilityOn = UserDefaults.standard.bool(forKey: "acessibilityMode")
    // false = left, true = right
    var whichEye = UserDefaults.standard.bool(forKey: "acessibilityEye")
    
    let targetValue = 0.12
    var leftEyePoints: [CGPoint] = []
    var rightEyePoints: [CGPoint] = []
    
    func detectEyes(on image: CIImage) {
        let request = VNDetectFaceLandmarksRequest { [weak self] request, error in
            guard let results = request.results as? [VNFaceObservation] else {
                self?.eyeStatus = .nofaceDetected
                return }
            if results.isEmpty {
                self?.eyeStatus = .nofaceDetected
                return
            }
            
            for face in results {
                guard let landmarks = face.landmarks else {
                    continue
                }
                guard let self = self else { return }
                
                let leftEyeClosed = self.checkEyeStatus(landmarks.leftEye)
                let rightEyeClosed = self.checkEyeStatus(landmarks.rightEye)
                
                if self.isAcessibilityOn {
                    if self.whichEye {
                        if rightEyeClosed < targetValue {
                            self.eyeStatus = .closed
                        }else {
                            self.eyeStatus = .opened
                        }
                    }
                    else {
                        if leftEyeClosed < targetValue {
                            self.eyeStatus = .closed
                        }else {
                            self.eyeStatus = .opened
                        }
                    }
                }else {
                    let currentAverage = (leftEyeClosed + rightEyeClosed)/2.0
                    if currentAverage < targetValue {
                        self.eyeStatus = .closed
                    } else {
                        self.eyeStatus = .opened
                    }
                }
            }
        }
        
        request.revision = VNDetectFaceLandmarksRequestRevision3
        
        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        try? handler.perform([request])
    }
    
    private func checkEyeStatus(_ eye: VNFaceLandmarkRegion2D?) -> CGFloat {
        guard let eye = eye, eye.pointCount >= 6 else { return 1 }
        
        let points = eye.normalizedPoints
        
        // 0: inner corner
        // 3: outer corner
        // 1, 2: upper eyelid
        // 4, 5: lower eyelid
        
        // Eye Aspect Ration Formula
        let v1 = distance(points[1], points[5])
        let v2 = distance(points[2], points[4])
        
        let h = distance(points[0], points[3])
        
        let ear = (v1 + v2) / (2.0 * h)
        
        return ear
    }

    private func distance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        return sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
    }
    
    func reloadSettings() {
        self.isAcessibilityOn = UserDefaults.standard.bool(forKey: "acessibilityMode")
        self.whichEye = UserDefaults.standard.bool(forKey: "acessibilityEye")
    }
}
