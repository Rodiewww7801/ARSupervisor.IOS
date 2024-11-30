//
//  RouteProvider.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import SwiftUI

/// Provide route for custom `NavigationController` to  select type of animated transition in `NavigationRoute`.
/// Not nessessary to implement. Used only for animation delegating in custom `NavigationController`.
@MainActor
public protocol RouteProvider {
    var route: (any NavigationRoute)? { get }
}

// MARK: - Example of implementation

public class RouteHostingController<Content: View>: UIHostingController<Content>, RouteProvider {
    public let route: (any NavigationRoute)?
    
    init(route: any NavigationRoute, rootView: Content) {
        self.route = route
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
