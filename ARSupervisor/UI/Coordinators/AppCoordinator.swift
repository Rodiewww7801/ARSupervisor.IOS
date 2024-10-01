//
//  AppCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 04.09.2024.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private let coordinatorFactory = dependency.coordinatorDependency.coordinatorFactory
    private(set) weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    
    private(set) var window: UIWindow
    private(set) var router: RouterProtocol
    
    init(router: RouterProtocol, window: UIWindow) {
        self.window = window
        self.window.rootViewController = router.navigationController
        self.window.makeKeyAndVisible()
        self.router = router
        Logger.logAllocation(for: self)
    }
    
    deinit {
        Logger.logDeallocation(for: self)
    }
    
    func start() {
        let coordinator = coordinatorFactory.makeMainCoordinator(self.router)
        coordinator.start()
    }
}
