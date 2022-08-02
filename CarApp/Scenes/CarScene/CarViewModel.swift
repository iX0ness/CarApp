//
//  CarViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

enum CarViewState {
    case loading
    case loaded(Car)
    case failed
}

protocol CarViewModelType: AnyObject {
    var didChangeState: ((CarViewState) -> Void)? { get set }
    
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
    func fetchCar()
    func fetchedCar() -> Car?
}

final class CarViewModel: CarViewModelType {
    
    var didChangeState: ((CarViewState) -> Void)?
    
    private let logoutService: LogoutServiceType
    private var mediator: CarViewModelMediatorType
    
    private var state: CarViewState = .loading {
        didSet { didChangeState?(state) }
    }
    
    private var car: Car? {
        didSet {
            if let car = car {
                state = .loaded(car)
            } else {
                state = .failed
            }
        }
    }
    
    init(logoutService: LogoutServiceType, mediator: CarViewModelMediatorType) {
        self.logoutService = logoutService
        self.mediator = mediator
        self.mediator.carViewModel = self
        bind()
    }
    
    deinit {
        print("\(CarViewModel.self) deinitialized")
    }
        
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        logoutService.logout(completion: completion)
    }
    
    func fetchCar() {
        state = .loading
        didChangeState?(.loading)
        
        APIClient.fetchCar { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                switch result {
                    case .success(let car):
                        self?.car = car
                    case.failure(let error):
                        print(error)
                        self?.car = nil
                }
            }
        }
    }
    
    func fetchedCar() -> Car? {
        if case let .loaded(car) = state {
            return car
        }
        
        return nil
    }
    
    private func bind() {
        mediator.didKilometrageUpdate = { [weak self] value in
            self?.car?.kilometrage = value
        }
    }
    
}
