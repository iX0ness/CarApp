//
//  AuthCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class AuthCoordinator: Coordinable {
    var presenter: UINavigationController?
    var didFinish: CoordinatorHandler?
    
    weak var parent: AppCoordinator?
    private let viewFactory: ViewFactory
    
    init() {
        viewFactory = ViewFactory()
    }
    
    deinit {
        print("\(LoginViewModel.self) deinitialized")
    }
    
    func start() {
        let viewController = viewFactory.makeLoginViewController()
        push(viewController, animated: true)
    }
    
}
