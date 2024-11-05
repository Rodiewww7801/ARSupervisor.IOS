//
//  ARSceneCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import SwiftUI

enum ARSceneRoute: NavigationRoute {
    case cameraAccessDenied
}

enum ARSceneRouteVC: NavigationRoute {
    case qrCode
}

class ARSceneCoordinator: Coordinator {
    private let router: RouterProtocol
    private let camaraManager: CameraManagerProtocol = dependency.domainDependency.cameraManager
    var childCoordinators: [any Coordinator] = []
    
    init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        Task {
            await checkCameraAccess()
        }
    }
    
    private func checkCameraAccess() async {
        let accessState = await camaraManager.requestCameraAccess()
        switch accessState {
        case .authorized:
            showQRScene()
        case .denied:
            showCameraAccessDenied()
        }
    }
    
    private func showQRScene() {
        let view: Presentable = QRCodeCaptureSessionVC(for: ARSceneRouteVC.qrCode)
        self.router.setRootModule(view, animated: true)
    }
    
    private func showCameraAccessDenied() {
        let view = self.factory(for: .cameraAccessDenied)
        self.router.setRootModule(view, animated: true)
    }
}

extension ARSceneCoordinator: RouteFactoryProtocol {
    @ViewBuilder
    func view(for route: ARSceneRoute) -> some View {
        switch route {
        case .cameraAccessDenied:
            CameraAccessDenied()
        }
    }
}
