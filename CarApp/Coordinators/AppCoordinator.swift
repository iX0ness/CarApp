//
//  AppCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 14/07/2022.
//

import UIKit


final class AppCoordinator: Coordinable {
    
    var presenter: UINavigationController?
    var flowCompletion: CoordinatorHandler?
    var childCoordinators: [Coordinable] = []
    private let viewFactory: ViewFactory
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        presenter = UINavigationController()
        viewFactory = ViewFactory()
        window?.rootViewController = presenter
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let vc = viewFactory.makeLoaderViewController()
        push(vc, animated: true)
    }
    
    
}
