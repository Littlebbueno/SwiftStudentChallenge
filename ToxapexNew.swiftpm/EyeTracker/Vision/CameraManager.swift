//
//  CameraManager.swift
//  Toxapex
//
//  Created by Marco Bueno on 15/01/26.
//

import AVFoundation
import CoreImage

@available(iOS 17.0, *)
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
        // Sessões de câmera devem ser iniciadas fora da Main Thread no iOS ( Tive esse aviso, ficar esperto com isso)
        self.captureSession.startRunning()
        
    }
}

// Criamos uma extensão para o Delegate para isolar o erro
@available(iOS 17.0, *)
extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // O segredo está aqui: marcar como 'nonisolated' e 'unsafe' se necessário
    nonisolated func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // Extraímos os dados sem tocar em 'self' ainda
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer).oriented(.leftMirrored)
        
        // Agora enviamos apenas a imagem (que é segura) para o MainActor
        Task { @MainActor in
            self.currentFrame = ciImage
        }
    }
}
