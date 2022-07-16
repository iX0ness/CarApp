//
//  Router.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 09/07/2022.
//

import Foundation
import UIKit

protocol Router {
    var presenter: UINavigationController? { get }
    
    func present(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Router {
    func present(_ viewController: UIViewController, animated: Bool = true) {
        presenter?.present(viewController, animated: animated)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        presenter?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        presenter?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        presenter?.dismiss(animated: animated, completion: completion)
    }
}
