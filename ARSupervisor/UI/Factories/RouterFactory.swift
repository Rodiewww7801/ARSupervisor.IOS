//
//  RouterFactory.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import UIKit

class RouterFactory: RouterFactoryProtocol {
    func makeAppRouter(_ navigationController: UINavigationController) -> RouterProtocol {
        return Router(navigationController)
    }
}
