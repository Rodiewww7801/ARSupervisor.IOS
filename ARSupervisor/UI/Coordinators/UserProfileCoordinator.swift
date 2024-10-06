//
//  UserProfileCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import SwiftUI

enum UserProfileRoute: NavigationRoute {
    case profile
}

class UserProfileCoordinator: Coordinator {
    private let router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = self.factory(for: .profile)
        self.router.setRootModule(view, animated: true)
    }
}

extension UserProfileCoordinator: RouteFactoryProtocol {
    func view(for route: UserProfileRoute) -> some View {
        ProfileView()
    }
}
