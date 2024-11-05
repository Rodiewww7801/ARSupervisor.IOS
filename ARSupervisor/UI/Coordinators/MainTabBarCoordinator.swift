//
//  MainTabBarCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import SwiftUI
import Combine

enum MainTabBarRoute: NavigationRoute, CaseIterable {
    case plainDataTab
    case arViewPresentationTab
    case profileTab
}

class MainTabBarCoordinator: Coordinator {
    private var router: RouterProtocol
    private var controller: TabBarController<MainTabBarRoute, MainTabBarItemsFactory>!
    var childCoordinators: [any Coordinator] = []
    
    // MARK: - Combine publishers
    private var subscribtions: Set<AnyCancellable> = .init()
    
    //MARK: - init
    init(_ router: RouterProtocol) {
        self.router = router
        self.router.navigationController.setNavigationBarHidden(true, animated: false)
        controller = TabBarController(selectedRoute: .arViewPresentationTab, factory: MainTabBarItemsFactory())
    }
    
    func start() {
        self.controller.onDidSelecteTab
            .sink { [weak self] route in
                self?.start(route)
            }.store(in: &subscribtions)
        self.router.setRootModule(self.controller, animated: true)
    }
    
    private func start(_ route: MainTabBarRoute) {
        switch route {
        case .plainDataTab:
            startPlainData()
        case .arViewPresentationTab:
            startARView()
        case .profileTab:
            startProfile()
        }
    }
    
    private func startPlainData() {
        guard childCoordinators.contains(where: { $0 is PlainDataCoordinator }) == false else { return }
        guard let nc = self.controller.getController(for: .plainDataTab) as? UINavigationController else {
            return
        }
        let router = Router(nc)
        let coordinator = PlainDataCoordinator(router)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func startARView() {
        guard childCoordinators.contains(where: { $0 is ARSceneCoordinator }) == false else { return }
        guard let nc = self.controller.getController(for: .arViewPresentationTab) as? UINavigationController else {
            return
        }
        let router = Router(nc)
        let coordinator = ARSceneCoordinator(router)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func startProfile() {
        guard childCoordinators.contains(where: { $0 is UserProfileCoordinator }) == false else { return }
        guard let nc = self.controller.getController(for: .profileTab) as? UINavigationController else {
            return
        }
        let router = Router(nc)
        let coordinator = UserProfileCoordinator(router)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}

