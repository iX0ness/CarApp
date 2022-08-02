//
//  Mediator.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation


protocol CarViewModelMediatorType: AnyObject {
    var carViewModel: CarViewModelMediatorInputType? { get set }
}

protocol KilometrageCorrectorViewModelMediatorType: AnyObject {
    var kilometrageCorrectorViewModel: KilometrageCorrectorViewModelMediatorInputType? { get set }
    func updateKilometrage(to value: Int)
}

protocol VinCorrectorMediatorType: AnyObject {
    var vinCorrectorViewModel: VinCorrectorViewModel? { get set }
    func updateVin(_ value: String)
}

protocol MediatorType {
    static var shared: CarViewModelMediatorType & KilometrageCorrectorViewModelMediatorType & VinCorrectorMediatorType { get }
}

final class Mediator: MediatorType {
    static var shared: CarViewModelMediatorType & KilometrageCorrectorViewModelMediatorType & VinCorrectorMediatorType = Mediator()
    
    weak var carViewModel: CarViewModelMediatorInputType?
    weak var kilometrageCorrectorViewModel: KilometrageCorrectorViewModelMediatorInputType?
    weak var vinCorrectorViewModel: VinCorrectorViewModel?

}


extension Mediator: VinCorrectorMediatorType {
    func updateVin(_ value: String) {
        carViewModel?.update(vin: value)
        kilometrageCorrectorViewModel?.update(vin: value)
    }
}

extension Mediator: KilometrageCorrectorViewModelMediatorType {
    func updateKilometrage(to value: Int) {
        carViewModel?.update(kilometrage: value)
    }
}

extension Mediator: CarViewModelMediatorType {}
