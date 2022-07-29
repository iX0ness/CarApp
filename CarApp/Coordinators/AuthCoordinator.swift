//
//  AuthCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didLogin()
}

final class AuthCoordinator: Coordinable {
    var presenter: UINavigationController?
    var didFinish: CoordinatorHandler?
    
    weak var parent: AppCoordinator?
    private let viewFactory: ViewFactory
    private let authorizationService: AuthorizationServiceType
    
    init() {
        viewFactory = ViewFactory()
        authorizationService = AuthorizationService()
    }
    
    deinit {
        print("\(AuthCoordinator.self) deinitialized")
    }
    
    func start() {
        let viewController = viewFactory.makeLoginViewController(authorizationService: authorizationService)
        viewController.coordinator = self
        push(viewController, animated: true)
    }
    
}

extension AuthCoordinator: LoginViewDelegate {
    func didLogin() {
        didFinish?()
        presenter?.popToRootViewController(animated: false)
    }
}
