//
//  NavigationControllerFactoryProtocol.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public protocol NavigationControllerFactoryProtocol {
    func makeNavigationController(deleagte: UINavigationControllerDelegate) -> UINavigationController
    func makeNavigationController() -> UINavigationController
}
