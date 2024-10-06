//
//  MainTabBarItemsFactory.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 05.10.2024.
//

import UIKit

class MainTabBarItemsFactory: TabBarItemsFactoryProtocol {
    func factory(for route: MainTabBarRoute) -> TabBarPresentable<MainTabBarRoute>  {
        let nc = dependency.navigationContrllerDependency.navigationControllerFactory.makeNavigationController(route)
        let item: TabBarPresentable<MainTabBarRoute>
        switch route {
        case .plainDataTab:
            item = TabBarPresentable<MainTabBarRoute>(nc, title: "Plain data", image: UIImage(systemName: "chart.xyaxis.line"), tag: 0)
        case .arViewPresentationTab:
            item = TabBarPresentable<MainTabBarRoute>(nc,title: "AR View", image: UIImage(systemName: "move.3d"), tag: 1)
        case .profileTab:
            item = TabBarPresentable<MainTabBarRoute>(nc, title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        }
        return item
    }
}
