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
    var car: Car? { get }
    
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
    func fetchCar()
}

final class CarViewModel: CarViewModelType {
    
    var didChangeState: ((CarViewState) -> Void)?
    
    var car: Car? {
        if case let .loaded(car) = state {
            return car
        }
        
        return nil
    }
    
    private let logoutService: LogoutServiceType
    private var mediator: CarViewModelMediatorType
    private var state: CarViewState = .loading
    
    init(logoutService: LogoutServiceType, mediator: CarViewModelMediatorType) {
        self.logoutService = logoutService
        self.mediator = mediator
        self.mediator.carViewModel = self
    }
    
    deinit {
        print("\(CarViewModel.self) deinitialized")
    }
        
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        logoutService.logout(completion: completion)
    }
    
    func foo() {
        //mediator.updateKilometrage(to: <#T##Int#>)
    }
    func fetchCar() {
        state = .loading
        didChangeState?(.loading)
        
        APIClient.fetchCar { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                switch result {
                    case .success(let car):
                        self?.state = .loaded(car)
                        self?.didChangeState?(.loaded(car))
                    case.failure(let error):
                        print(error)
                        self?.state = .failed
                        self?.didChangeState?(.failed)
                }
            }
        }

    }
    
}
