//
//  RouteFactory.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import SwiftUI

/// Obliges a class that implements this protocol to be responsible for creating a view use Route type
public protocol RouteFactoryProtocol {
    associatedtype Route: NavigationRoute
    associatedtype V

    /// shouldn't be called directly. Only via factory method
    func view(for route: Route) -> V
}

extension RouteFactoryProtocol where V: View  {
    /// create and wrap view to Presentable
    public func factory(for route: Route) -> Presentable {
        let view = self.view(for: route)
        let wrappedView = self.wrapView(route: route, rootView: view)
        return wrappedView
    }
    
    private func wrapView(route: Route, rootView: V) -> Presentable {
        let wrappedView = RouteHostingController(route: route, rootView: rootView)
        return wrappedView
    }
}

extension RouteFactoryProtocol where V: Presentable {
    public func factory(for route: Route) -> Presentable {
        let viewController = self.view(for: route)
        return viewController
    }
}

extension RouteFactoryProtocol where V: UITabBarItem {
    public func factory(for route: Route) -> UITabBarItem {
        let viewController = self.view(for: route)
        return viewController
    }
}

// MARK: - Concrete Factory Protocols
public protocol RouteViewControllerFactoryProtocol: RouteFactoryProtocol {
    func view(for route: Route) -> UIViewController
}

public protocol RouteViewFactoryProtocol: RouteFactoryProtocol {
    /// shouldn't be called directly. Only via factory method
    func view(for route: Route) -> V
}

public protocol RouteTabBarFactoryProtocol: RouteFactoryProtocol {
    func view(for route: Route) -> UITabBarItem
}
