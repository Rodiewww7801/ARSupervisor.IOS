//
//  PlainDataCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import SwiftUI

enum PlainDataRoute: NavigationRoute {
    case plainData
}

class PlainDataCoordinator: Coordinator {
    private let router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = self.factory(for: .plainData)
        self.router.setRootModule(view, animated: true)
        let view2 = self.factory(for: .plainData)
        self.router.push(view2, animated: true)
    }
}

extension PlainDataCoordinator: RouteFactoryProtocol {
    func view(for route: PlainDataRoute) -> some View {
        PlainDataView()
    }
}
