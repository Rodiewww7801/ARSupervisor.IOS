//
//  RouterFactoryProtocol.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import UIKit

@MainActor
protocol RouterFactoryProtocol {
    func makeAppRouter(_ navigationController: UINavigationController) -> RouterProtocol
}
