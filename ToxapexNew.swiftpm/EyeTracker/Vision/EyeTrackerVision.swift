//
//  EyeTracker.swift
//  Toxapex
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


@available(iOS 17.0, *)
@Observable
class EyeTracker{
    var eyeStatus: eyeStatus = .nofaceDetected
    
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
                
                let leftEyeClosed = self?.checkEyeStatus(landmarks.leftEye) ?? false
                let rightEyeClosed = self?.checkEyeStatus(landmarks.rightEye) ?? false
                
                if leftEyeClosed && rightEyeClosed {
                    self?.eyeStatus = .closed
                } else {
                    self?.eyeStatus = .opened
                }
                self?.rightEyePoints = self?.convertPoints(landmarks.leftEye) ?? []
                self?.leftEyePoints = self?.convertPoints(landmarks.rightEye) ?? []
                
            }
        }
        
        request.revision = VNDetectFaceLandmarksRequestRevision3
        
        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        try? handler.perform([request])
    }
    
    private func checkEyeStatus(_ eye: VNFaceLandmarkRegion2D?) -> Bool {
        guard let eye = eye, eye.pointCount > 0 else { return false }
        
        // No Vision, podemos usar o EAR manual (testar depois).
        let points = eye.normalizedPoints
        if points.count < 6 { return false }
        
        let topY = (points[1].y + points[2].y) / 2
        let bottomY = (points[4].y + points[5].y) / 2
        
        let distance = abs(topY - bottomY)
        return distance < 0.020
    }
    
    private func convertPoints(_ region: VNFaceLandmarkRegion2D?) -> [CGPoint] {
        guard let region = region else { return [] }
        return region.normalizedPoints.map { CGPoint(x: $0.x, y: $0.y) }
    }
}

struct LandmarksOverlay: View {
    let points: [CGPoint]
    let size: CGSize
    let color: Color

    var body: some View {
        Canvas { context, size in
            for (index, point) in points.enumerated() {
                let x = point.x * size.width
                let y = point.y * size.height
                
                let rect = CGRect(x: x - 2, y: y - 2, width: 4, height: 4)
                context.fill(Path(ellipseIn: rect), with: .color(color))
                
                context.draw(Text("\(index)").font(.system(size: 8)), at: CGPoint(x: x + 5, y: y))
            }
        }
    }
}
