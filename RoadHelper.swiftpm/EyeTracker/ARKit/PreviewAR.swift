//
//  PreviewAR.swift
//  Toxapex
//
//  Created by Marco Bueno on 02/02/26.
//

import SwiftUI
import ARKit
import RealityKit

struct ARCameraView: UIViewRepresentable {
    let session: ARSession

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.session = session

//        let faceAnchor = AnchorEntity(.face)
//        
//
//        let material = SimpleMaterial(color: .blue.withAlphaComponent(0.2), isMetallic: true)
//        
//
//        let faceEntity = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [material])
//        faceEntity.name = "faceMesh"
//        
//        faceAnchor.addChild(faceEntity)
//        arView.scene.addAnchor(faceAnchor)
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
