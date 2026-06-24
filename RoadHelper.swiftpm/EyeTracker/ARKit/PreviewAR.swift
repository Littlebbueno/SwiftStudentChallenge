//
//  PreviewAR.swift
//  RoadHelper
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
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
