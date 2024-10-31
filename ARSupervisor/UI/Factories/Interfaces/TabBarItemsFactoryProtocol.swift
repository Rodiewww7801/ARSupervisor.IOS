//
//  TabBarItemsFactoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 06.10.2024.
//

@MainActor
protocol TabBarItemsFactoryProtocol {
    associatedtype Route: NavigationRoute
    func factory(for route: Route) -> TabBarPresentable<Route>
}
