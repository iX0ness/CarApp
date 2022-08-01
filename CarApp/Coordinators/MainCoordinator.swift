//
//  MainCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

protocol CarViewDelegate: AnyObject {
    func showKilometrageCorrectorView()
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
        let viewController = viewFactory.makeCarViewController(
            logoutService: logoutService,
            mediator: Mediator.shared
        )
        viewController.coordinator = self
        push(viewController, animated: true)
    }

}

extension MainCoordinator: CarViewDelegate {
    func showKilometrageCorrectorView() {
        let viewController = viewFactory.makeKilometrageCorrectorViewcontroller()
        push(viewController, animated: true)
    }
    
    func logout() {
        didFinish?()
        presenter?.popToRootViewController(animated: false)
    }
}
