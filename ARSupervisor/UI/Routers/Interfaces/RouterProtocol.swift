//
//  RouterProtocol.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

public typealias Presentable = UIViewController & RouteProvider

/// `Router` encapsulate specific navigation logic.
public protocol RouterProtocol {
    var navigationController: UINavigationController { get }

    func push(_ module: Presentable, animated: Bool)
    func push(_ modules: [Presentable], animated: Bool)
    func present(_ module: Presentable, withDelegate delegate: UIViewControllerTransitioningDelegate?, style: UIModalPresentationStyle, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func popTo(_ module: Presentable, animated: Bool)
}

public extension RouterProtocol {
    func push(_ module: Presentable, animated: Bool) {
        navigationController.pushViewController(module, animated: animated)
    }
    
    func push(_ modules: [Presentable], animated: Bool) {
        let viewControllers = self.navigationController.viewControllers
        navigationController.setViewControllers(viewControllers + modules, animated: animated)
    }

    func present(_ module: Presentable, withDelegate delegate: UIViewControllerTransitioningDelegate? = nil, style: UIModalPresentationStyle = .fullScreen, animated: Bool) {
        if let delegate {
            module.transitioningDelegate = delegate
        }
        module.modalPresentationStyle = style
        navigationController.present(module, animated: animated)
    }

    func pop(animated: Bool) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }

    func popToRoot(animated: Bool) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated)
        }
        navigationController.popToRootViewController(animated: animated)
    }

    func popTo(_ module: Presentable, animated: Bool) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated)
        }
        navigationController.popToViewController(module, animated: animated)
    }
}
