//
//  KilometrageCorrectorViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol KilometrageCorrectorViewModelType: AnyObject {
    var didCarUpdate: ((Car) -> Void)? { get set }
    var car: Car { get }
    
    func viewDidLoad(completion: (Int) -> Void)
    func changeKilometrage(to value: Int)
}

final class KilometrageCorrectorViewModel: KilometrageCorrectorViewModelType {
    
    var didCarUpdate: ((Car) -> Void)?
    var car: Car {
        didSet { didCarUpdate?(car) }
    }
    private var mediator: KilometragecorrectorViewModelMediatorType
    
    init(car: Car, mediator: KilometragecorrectorViewModelMediatorType) {
        self.car = car
        self.mediator = mediator
        self.mediator.kilometrageCorrectorViewModel = self
    }
    
    deinit {
        print("\(KilometrageCorrectorViewModel.self) deinitialized")
    }
    
    func viewDidLoad(completion: (Int) -> Void) {
        didCarUpdate?(car)
        completion(car.kilometrage)
    }
    
    func changeKilometrage(to value: Int) {
        car.kilometrage = value
        mediator.updateKilometrage(to: value)
    }
}
