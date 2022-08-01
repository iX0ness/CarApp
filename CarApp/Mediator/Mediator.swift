//
//  Mediator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation


protocol CarViewModelMediatorType: AnyObject {
    var carViewModel: CarViewModel! { get set }
    func updateVin(_ value: String)
}

protocol KilometragecorrectorViewModelMediatorType: AnyObject {
    var kilometrageCorrectorViewModel: KilometrageCorrectorViewModel! { get set }
    func updateKilometrage(to value: Int)
}
protocol MediatorType {
    static var shared: CarViewModelMediatorType & KilometragecorrectorViewModelMediatorType { get }
}

final class Mediator: MediatorType {
    static var shared: CarViewModelMediatorType & KilometragecorrectorViewModelMediatorType = Mediator()
    
    unowned var carViewModel: CarViewModel!
    unowned var kilometrageCorrectorViewModel: KilometrageCorrectorViewModel!
}


extension Mediator: CarViewModelMediatorType {
    func updateVin(_ value: String) {
        
    }
}

extension Mediator: KilometragecorrectorViewModelMediatorType {
    func updateKilometrage(to value: Int) {
        
    }
}
