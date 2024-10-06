//
//  TabBarController.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 04.10.2024.
//

import Combine
import SwiftUI


class TabBarController<Route, Factory>: UITabBarController, RouteProvider
where Route: NavigationRoute & CaseIterable,
      Factory: TabBarItemsFactoryProtocol,
      Factory.Route == Route {
    private var items: [TabBarPresentable<Route>] = []
    private(set) var selectedRoute: Route!
    var route: (any NavigationRoute)?
    
    // MARK: - Combine publishers
    private let _onDidSelecteTab: CurrentValueSubject<Route, Never>
    lazy var onDidSelecteTab: AnyPublisher<Route, Never> = _onDidSelecteTab.eraseToAnyPublisher()
    
    
    // MARK: - init
    
    init(selectedRoute: Route, factory: Factory) {
        self._onDidSelecteTab = CurrentValueSubject<Route, Never>(selectedRoute)
        super.init(nibName: nil, bundle: nil)
        var items: [TabBarPresentable<Route>] = []
        for route in Route.allCases {
            let item = factory.factory(for: route)
            items.append(item)
        }
        
        self.items = items
        self.viewControllers = items.map { $0.viewController }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.selectRoute(selectedRoute)
    }
    
    func selectRoute(_ route: Route) {
        guard let vc = self.getController(for: route) else { return }
        self.selectedViewController = vc
        self.selectedRoute = route
        self._onDidSelecteTab.send(route)
    }
    
    func getController(for route: Route) -> Presentable? {
        self.items.first(where: { $0.route == route})?.viewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let _item = self.items.first(where: { $0.item.tag == item.tag }),
              let route = _item.route
        else {
            return
        }
        self._onDidSelecteTab.send(route)
    }
}
