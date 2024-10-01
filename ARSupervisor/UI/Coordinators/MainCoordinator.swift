//
//  MainCoordinator.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

class MainCoordinator: Coordinator {
    private var coordinatorFactory = dependency.coordinatorDependency.coordinatorFactory
    private var router: RouterProtocol
    var childCoordinators: [any Coordinator] = []
    
    
    init(router: RouterProtocol) {
        self.router = router
        Logger.logAllocation(for: self)
    }
    
    deinit {
        Logger.logDeallocation(for: self)
    }
    
    func start() {
        startLoginFlow()
    }
    
    func startLoginFlow() {
        let coordinator = coordinatorFactory.makeLoginCoordinator(router)
        coordinator.start()
    }
    
}
