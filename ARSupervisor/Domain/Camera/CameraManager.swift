//
//  Camera.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 04.11.2024.
//

import AVFoundation

class CameraManager: CameraManagerProtocol {
    
    func requestCameraAccess() async -> CameraAccessState {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                return .authorized
            } else {
                return .denied
            }
        case .restricted, .denied: return .denied
        case .authorized: return .authorized
        @unknown default: return .denied
        }
    }
}
