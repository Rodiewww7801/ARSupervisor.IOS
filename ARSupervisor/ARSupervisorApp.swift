//
//  ARSupervisorApp.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

import SwiftUI

var dependency: DependencyContainer = DependencyContainerProtected.shared

@main
struct SwiftCoordinatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup { }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private var appCoordinator: Coordinator!
    private var navigationControllerFactory = dependency.navigationContrllerDependency.navigationControllerFactory
    private var coordinatorFactory = dependency.coordinatorDependency.coordinatorFactory
    private var routerFactory = dependency.routerDependency.routerFactory
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }
        
        let navigationController = navigationControllerFactory.makeNavigationController()
        let appRouter = routerFactory.makeAppRouter(navigationController)
        let appCoordinator = coordinatorFactory.makeAppCoordinator(appRouter, window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}
