//
//  NavigationControllerFactory.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public class NavigationControllerFactory: NavigationControllerFactoryProtocol {
    public func makeNavigationDelegate() -> UINavigationControllerDelegate {
        let transitionHandler = NavigationControllerTransitionHandler()
        return NavigationControllerDelegateProxy(transitionHandler: transitionHandler)
    }
    
    public func makeNavigationController(deleagte: UINavigationControllerDelegate) -> UINavigationController {
        let navigationController = NavigationController(delegate: deleagte)
        return navigationController
    }
    
    public func makeNavigationController() -> UINavigationController {
        let delegate = self.makeNavigationDelegate()
        let navigationController = self.makeNavigationController(deleagte: delegate)
        return navigationController
    }
}
