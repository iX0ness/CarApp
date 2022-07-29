//
//  AppCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 14/07/2022.
//

import UIKit


protocol LoaderDelegate: AnyObject {
    func runAuthFlow()
    func runMainFlow()
}

final class AppCoordinator: Coordinable {
    
    var presenter: UINavigationController?
    var didFinish: CoordinatorHandler?
    var childCoordinators: [Coordinable] = []
    private let viewFactory: ViewFactory
    private let coordinatorFactory: CoordinatorFactory
    
    var window: UIWindow?
    
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

extension AppCoordinator: LoaderDelegate {
    func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator()
        coordinator.presenter = presenter
        childCoordinators.append(coordinator)
        
        coordinator.didFinish = { [weak coordinator] in
            self.childCoordinators.removeAll(where: { $0 === coordinator })
        }
        
        coordinator.start()
    }
    
    func runMainFlow() {
        
    }
    
    
}
