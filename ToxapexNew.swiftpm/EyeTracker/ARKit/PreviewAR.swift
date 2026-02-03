//
//  PreviewAR.swift
//  Toxapex
//
//  Created by Marco Bueno on 02/02/26.
//

import SwiftUI
import ARKit

struct ARCameraView: UIViewRepresentable {
    let session: ARSession

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.session = session
        arView.automaticallyUpdatesLighting = true
        
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}
