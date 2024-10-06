//
//  MainCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI
import Combine

enum MainRoute: NavigationRoute {
    case login
    case main
}

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
        self.childCoordinators.append(coordinator)
        coordinator.onSuccessLogin
            .sink(receiveValue: { [weak self, weak coordinator] _ in
                guard let self, let coordinator else { return }
                self.remove(coordinator)
                self.startMainFlow()
            })
            .store(in: &subscriptions)
        coordinator.start()
    }
    
    func startMainFlow() {
        let coordinator = MainTabBarCoordinator(self.router)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
