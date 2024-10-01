//
//  AppCoordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 04.09.2024.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private(set) weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    
    private(set) var window: UIWindow
    private(set) var navigationController: UINavigationController
    private(set) var router: RouterProtocol
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        self.router = dependency.routerFactory.makeAppRouter(navigationController)

        Logger.logAllocation(for: self)
    }
    
    deinit {
        Logger.logDeallocation(for: self)
    }
    
    func start() {
        let coordinator = dependency.coordinatorFactory.makeMainCoordinator(self.router)
        coordinator.start()
    }
}
