//
//  MainCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

protocol ActivityViewDelegate: AnyObject {
    func showActivityModifyView()
    func logout()
}

final class MainCoordinator: Coordinable {
    
    weak var parent: AppCoordinator?
    var presenter: UINavigationController?
    var didFinish: CoordinatorHandler?
    
    private let viewFactory: ViewFactory
    private let logoutService: LogoutServiceType
    
    init() {
        viewFactory = ViewFactory()
        logoutService = LogoutService()
    }
    
    deinit {
        print("\(MainCoordinator.self) deinitialized")
    }
    
    func start() {
        let viewController = viewFactory.makeActivityViewController(logoutService: logoutService)
        viewController.coordinator = self
        push(viewController, animated: true)
    }

}

extension MainCoordinator: ActivityViewDelegate {
    func showActivityModifyView() {
        let viewController = viewFactory.makeActivityModifyViewcontroller()
        push(viewController, animated: true)
    }
    
    func logout() {
        didFinish?()
        presenter?.popToRootViewController(animated: false)
    }
}
