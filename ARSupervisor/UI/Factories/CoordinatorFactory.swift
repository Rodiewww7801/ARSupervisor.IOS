//
//  CoordinatorFactory.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import UIKit

class CoordinatorFactory: CoordinatorFactoryProtocol {
    var appCoordinator: Coordinator? = nil
    
    func makeAppCoordinator(window: UIWindow, navigationController: UINavigationController) -> Coordinator {
        let appCoordinator = AppCoordinator(window: window, navigationController: navigationController)
        self.appCoordinator = appCoordinator
        return appCoordinator
    }
    
    func makeMainCoordinator(_ router: RouterProtocol) -> Coordinator {
        return MainCoordinator(router: router)
    }
    
    func makeLoginCoordinator(_ router: any RouterProtocol) -> any Coordinator {
        return LoginCoordinator(router: router)
    }
}
