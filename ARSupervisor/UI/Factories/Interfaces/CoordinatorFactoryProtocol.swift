//
//  CoordinatorFactoryProtocol.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import UIKit

protocol CoordinatorFactoryProtocol {
    var appCoordinator: Coordinator? { get }
    func makeAppCoordinator(window: UIWindow, navigationController: UINavigationController) -> Coordinator
    func makeMainCoordinator(_ router: RouterProtocol) -> Coordinator
    func makeLoginCoordinator(_ router: RouterProtocol) -> Coordinator
}
