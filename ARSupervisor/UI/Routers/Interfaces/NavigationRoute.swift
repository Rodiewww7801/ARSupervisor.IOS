//
//  NavigationRoute.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

/// `NavigationRoute` Need to segregate views by abstract type.
public protocol NavigationRoute {
    /// Coordinates a transition between ViewControllers
    var transitionType: AnimatedTransitioning? { get }
}

public extension NavigationRoute {
    var transitionType: AnimatedTransitioning? {
        return nil
    }
}

public struct AnimatedTransitioning {
    var transitionTo: UIViewControllerAnimatedTransitioning? = nil
    var transitionFrom: UIViewControllerAnimatedTransitioning? = nil
    
    public init(transitionTo: UIViewControllerAnimatedTransitioning? = nil, transitionFrom: UIViewControllerAnimatedTransitioning? = nil) {
        self.transitionTo = transitionTo
        self.transitionFrom = transitionFrom
    }
}
