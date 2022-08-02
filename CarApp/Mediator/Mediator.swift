//
//  Mediator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation


protocol CarViewModelMediatorType: AnyObject {
    var carViewModel: CarViewModel! { get set }
    var didKilometrageUpdate: ((Int) -> Void)? { get set }
}

protocol KilometragecorrectorViewModelMediatorType: AnyObject {
    var kilometrageCorrectorViewModel: KilometrageCorrectorViewModel! { get set }
    func updateKilometrage(to value: Int)
}

protocol VinCorrectorMediatorType: AnyObject {
    var vinCorrectorViewModel: VinCorrectorViewModelType! { get set }
    func updateVin(_ value: String)
}

protocol MediatorType {
    static var shared: CarViewModelMediatorType & KilometragecorrectorViewModelMediatorType & VinCorrectorMediatorType { get }
}

final class Mediator: MediatorType {
    static var shared: CarViewModelMediatorType & KilometragecorrectorViewModelMediatorType & VinCorrectorMediatorType = Mediator()
    
    unowned var carViewModel: CarViewModel!
    unowned var kilometrageCorrectorViewModel: KilometrageCorrectorViewModel!
    unowned var vinCorrectorViewModel: VinCorrectorViewModelType!
    
    var didKilometrageUpdate: ((Int) -> Void)?
}


extension Mediator: VinCorrectorMediatorType {
    func updateVin(_ value: String) {
        
    }
}

extension Mediator: KilometragecorrectorViewModelMediatorType {
    func updateKilometrage(to value: Int) {
        didKilometrageUpdate?(value)
    }
}

extension Mediator: CarViewModelMediatorType {}
