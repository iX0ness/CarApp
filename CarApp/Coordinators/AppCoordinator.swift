//
//  AppCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 14/07/2022.
//

import UIKit


protocol LoaderViewDelegate: AnyObject {
    func runAuthFlow()
    func runMainFlow()
}

final class AppCoordinator: Coordinable {
    
    var window: UIWindow?
    
    var presenter: UINavigationController?
    var didFinish: CoordinatorHandler?
    var childCoordinators: [Coordinable] = []
    private let viewFactory: ViewFactory
    private let coordinatorFactory: CoordinatorFactory
    
    init(window: UIWindow?) {
        self.window = window
        presenter = UINavigationController()
        viewFactory = ViewFactory()
        coordinatorFactory = CoordinatorFactory()
        window?.rootViewController = presenter
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let viewController = viewFactory.makeLoaderViewController()
        viewController.coordinator = self
        push(viewController, animated: true)
    }
    
}

extension AppCoordinator: LoaderViewDelegate {
    
    func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator()
        coordinator.presenter = presenter
        coordinator.parent = self
        childCoordinators.append(coordinator)
        
        coordinator.didFinish = { [weak coordinator, weak self] in
            self?.childCoordinators.removeAll(where: { $0 === coordinator })
        }
        
        coordinator.start()
    }
    
    func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator()
        coordinator.presenter = presenter
        coordinator.parent = self
        childCoordinators.append(coordinator)
        
        coordinator.didFinish = { [weak coordinator, weak self] in
            self?.childCoordinators.removeAll(where: { $0 === coordinator })
        }
        
        coordinator.start()
    }
    
}
