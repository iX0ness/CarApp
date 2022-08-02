//
//  VinCorrectorViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 01/08/2022.
//

import Foundation

protocol VinCorrectorViewModelType: AnyObject {
    var didCarUpdate: ((Car) -> Void)? { get set }
    
    func viewDidLoad(completion: (String) -> Void)
    func set(vin: String?, completion: (String) -> Void)
}

final class VinCorrectorViewModel: VinCorrectorViewModelType {
    
    var didCarUpdate: ((Car) -> Void)?
    
    private let mediator: VinCorrectorMediatorType
    private var car: Car {
        didSet {
            didCarUpdate?(car)
        }
    }
    
    init(car: Car, mediator: VinCorrectorMediatorType) {
        self.car = car
        self.mediator = mediator
    }
    
    deinit {
        print("\(VinCorrectorViewModel.self) deinitialized")
    }
    
    func viewDidLoad(completion: (String) -> Void) {
        completion(car.vin)
        didCarUpdate?(car)
    }
    
    func set(vin: String?, completion: (String) -> Void) {
        vin.map { [weak self] vin in
            let trimmed = vin.trimmingCharacters(in: .whitespaces)
            self?.car.vin = trimmed
            self?.mediator.updateVin(trimmed)
            completion(trimmed)
        }
    }
    
}
