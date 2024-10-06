//
//  ARPresentationCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import SwiftUI

enum ARPresentationRoute: NavigationRoute {
    case arView
}

class ARPresentationCoordinator: Coordinator {
    private let router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = self.factory(for: .plainData)
        self.router.setRootModule(view, animated: true)
    }
}

extension ARPresentationCoordinator: RouteFactoryProtocol {
    func view(for route: PlainDataRoute) -> some View {
        ARView()
    }
}
