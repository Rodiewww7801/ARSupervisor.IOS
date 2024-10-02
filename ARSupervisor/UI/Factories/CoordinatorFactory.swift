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
    
    func makeAppCoordinator(_ router: RouterProtocol, window: UIWindow) -> Coordinator {
        let appCoordinator = AppCoordinator(router: router, window: window)
        self.appCoordinator = appCoordinator
        return appCoordinator
    }
    
    func makeMainCoordinator(_ router: RouterProtocol) -> Coordinator {
        return MainCoordinator(router: router)
    }
    
    func makeLoginCoordinator(_ router: any RouterProtocol) -> Coordinator & LoginCoordinatorOutput {
        return LoginCoordinator(router: router)
    }
}
