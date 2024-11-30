//
//  TabBarItem.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import SwiftUI

@MainActor
class TabBarPresentable<Route: NavigationRoute> {
    var viewController: Presentable!
    var item: UITabBarItem {
        viewController.tabBarItem!
    }
    
    var route: Route?  {
        return (viewController as? RouteProvider)?.route as? Route
    }
    
    init(_ viewController: Presentable, title: String?, image: UIImage?, tag: Int) {
        self.viewController = viewController
        self.viewController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
}
