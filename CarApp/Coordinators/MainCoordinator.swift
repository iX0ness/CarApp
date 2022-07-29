//
//  MainCoordinator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

protocol ActivityViewDelegate: AnyObject {
    func showActivityModifyView()
}

final class MainCoordinator: Coordinable {
    var presenter: UINavigationController?
    var didFinish: CoordinatorHandler?
    
    weak var parent: AppCoordinator?
    
    func start() {
        
    }

}

extension MainCoordinator: ActivityViewDelegate {
    func showActivityModifyView() {}
}
