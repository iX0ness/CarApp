//
//  Coordinable.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 09/07/2022.
//

import Foundation

typealias CoordinatorHandler = () -> ()

protocol Coordinable: AnyObject, Router {
    var didFinish: CoordinatorHandler? { get }
    func start()
}

protocol FlowController {
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
