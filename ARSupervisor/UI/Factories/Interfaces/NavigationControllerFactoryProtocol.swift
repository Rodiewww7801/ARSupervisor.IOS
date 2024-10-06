//
//  NavigationControllerFactoryProtocol.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public protocol NavigationControllerFactoryProtocol {
    func makeNavigationController(_ route: (any NavigationRoute), delegate: UINavigationControllerDelegate) -> UINavigationController & RouteProvider
    func makeNavigationController(_ route: (any NavigationRoute)) -> UINavigationController & RouteProvider
    func makeNavigationController(delegate: UINavigationControllerDelegate) -> UINavigationController & RouteProvider
    func makeNavigationController() -> UINavigationController & RouteProvider
}
