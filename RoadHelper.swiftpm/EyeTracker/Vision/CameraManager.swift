//
//  CameraManager.swift
//  Toxapex
//
//  Created by Marco Bueno on 15/01/26.
//

import AVFoundation
import CoreImage

@MainActor @Observable
class CameraManager: NSObject {
    var currentFrame: CIImage?
    
    let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sessionQueue = DispatchQueue(label: "videoQueue")
    
    override init() {
        super.init()
        setupSession()
    }
    
    
    private func setupSession() {
        captureSession.beginConfiguration()
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else { return }
        
        captureSession.addInput(videoDeviceInput)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
            videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        }
        
        captureSession.commitConfiguration()
    }
    
    func start() {
        self.captureSession.startRunning()
        
    }
}


extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    nonisolated func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer).oriented(.leftMirrored)
        
        Task { @MainActor in
            self.currentFrame = ciImage
        }
    }
}
