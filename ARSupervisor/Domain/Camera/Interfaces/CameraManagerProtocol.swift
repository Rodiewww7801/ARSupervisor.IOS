//
//  CameraManagerProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 04.11.2024.
//

protocol CameraManagerProtocol {
    @MainActor
    func requestCameraAccess() async -> CameraAccessState
}
