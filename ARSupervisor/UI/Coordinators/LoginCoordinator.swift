//
//  LoginCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI
import Combine

class LoginCoordinator: Coordinator, LoginCoordinatorOutput {
    private var router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    // MARK: - Combine publishers
    private var subscriptions: Set<AnyCancellable> = .init()
    private let _onSuccessLogin = PassthroughSubject<Void, Never>()
    lazy var onSuccessLogin: AnyPublisher<Void, Never> = _onSuccessLogin.eraseToAnyPublisher()
    
    // MARK: - init
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

// MARK: - Views Factory

enum LoginRoute: NavigationRoute {
    case login
}

extension LoginCoordinator: RouteFactoryProtocol {
    func view(for route: LoginRoute) -> some View {
        switch route {
        case .login:
            let viewModel = LoginViewModel()
            viewModel.$onSuccessLogin
                .sink { [weak self] success in
                    if success {
                        self?._onSuccessLogin.send(Void())
                    }
                }
                .store(in: &subscriptions)
            return LoginView(viewModel: viewModel)
        }
    }
}
