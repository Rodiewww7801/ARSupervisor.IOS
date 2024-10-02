//
//  MainCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI
import Combine

class MainCoordinator: Coordinator {
    private var coordinatorFactory = dependency.coordinatorDependency.coordinatorFactory
    private var router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    // MARK: - Combine publishers
    private var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: - init
    init(router: RouterProtocol) {
        self.router = router
        Logger.logAllocation(for: self)
    }
    
    deinit {
        Logger.logDeallocation(for: self)
    }
    
    func start() {
        startLoginFlow()
    }
    
    func startLoginFlow() {
        let coordinator = coordinatorFactory.makeLoginCoordinator(router)
        coordinator.onSuccessLogin
            .sink(receiveValue: { _ in
                self.startSecretFlow()
            })
            .store(in: &subscriptions)
        coordinator.start()
    }
    
    func startSecretFlow() {
        let view = factory(for: .secret)
        router.setRootModule(view, animated: true)
    }
}

// MARK: - Views Factory

enum MainRoute: NavigationRoute {
    case secret
}

extension MainCoordinator: RouteFactoryProtocol {
    @ViewBuilder
    func view(for route: MainRoute) -> some View {
        switch route {
        case .secret:
            AnyView {
                VStack {
                    Spacer()
                    Text("Secret view")
                    Spacer()
                }
            }
        }
    }
}
