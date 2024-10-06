//
//  NavigationControllerFactory.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public class NavigationControllerFactory: NavigationControllerFactoryProtocol {
    public func makeNavigationController(_ route: (any NavigationRoute), delegate: any UINavigationControllerDelegate) -> any UINavigationController & RouteProvider {
        self._makeNavigationController(route, delegate: delegate)
    }
    
    public func makeNavigationController(_ route: (any NavigationRoute)) -> any UINavigationController & RouteProvider {
        self._makeNavigationController(route)
    }
    
    public func makeNavigationController(delegate: any UINavigationControllerDelegate) -> any UINavigationController & RouteProvider {
        self._makeNavigationController(delegate: delegate)
    }
    
    public func makeNavigationController() -> any UINavigationController & RouteProvider {
        self._makeNavigationController()
    }
    
    private func _makeNavigationDelegate() -> UINavigationControllerDelegate {
        let transitionHandler = NavigationControllerTransitionHandler()
        return NavigationControllerDelegateProxy(transitionHandler: transitionHandler)
    }
    
    private func _makeNavigationController(_ route: (any NavigationRoute)? = nil, delegate: UINavigationControllerDelegate) -> UINavigationController & RouteProvider  {
        let navigationController = NavigationController(delegate: delegate, route: route)
        return navigationController
    }
    
    private func _makeNavigationController(_ route: (any NavigationRoute)? = nil) -> UINavigationController & RouteProvider   {
        let delegate = self._makeNavigationDelegate()
        let navigationController = self._makeNavigationController(route, delegate: delegate)
        return navigationController
    }
}
