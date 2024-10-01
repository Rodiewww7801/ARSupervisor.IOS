//
//  NavigationController.swift
//
//
//  Created by Rodion Hladchenko on 10.09.2024.
//

import UIKit

///  Custom `NavigationController` hides transition logic which animation is need for ViewController
///  using its own delegate that handle selected type of animation implemented in `NavigationRoute`.
public class NavigationController: UINavigationController {
    private var hardReferenceToDelegate: UINavigationControllerDelegate?
    
    convenience init(delegate: UINavigationControllerDelegate? = nil) {
        self.init(nibName: nil, bundle: nil)
        self.hardReferenceToDelegate = delegate
        self.delegate = delegate
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
