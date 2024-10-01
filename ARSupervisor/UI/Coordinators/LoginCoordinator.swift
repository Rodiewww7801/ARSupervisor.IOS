//
//  LoginCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI

enum LoginRoute: NavigationRoute {
    case login
}

class LoginCoordinator: Coordinator {
    private var router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    init(router: RouterProtocol) {
        self.router = router
        Logger.logAllocation(for: self)
    }
    
    deinit {
        Logger.logDeallocation(for: self)
    }
    
    func start() {
        showLoginView()
    }
    
    func showLoginView() {
        let view = factory(for: .login)
        router.push(view, animated: true)
    }
}

extension LoginCoordinator: RouteFactoryProtocol {
    typealias Route = LoginRoute
    
    func view(for route: LoginRoute) -> some View {
        switch route {
        case .login:
            LoginView(viewModel: LoginViewModel())
        }
    }
}
