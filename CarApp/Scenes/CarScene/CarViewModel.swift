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
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
    func fetchCar()
    var didChangeState: ((CarViewState) -> Void)? { get set }
}

final class CarViewModel: CarViewModelType {
    
    private let logoutService: LogoutServiceType
    private var state: CarViewState = .loading
    var didChangeState: ((CarViewState) -> Void)?
    
    init(logoutService: LogoutServiceType) {
        self.logoutService = logoutService
    }
    
    deinit {
        print("\(CarViewModel.self) deinitialized")
    }
    
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        logoutService.logout(completion: completion)
    }
    
    func fetchCar() {
        didChangeState?(.loading)
        
        APIClient.fetchCar { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                switch result {
                    case .success(let car):
                        self?.didChangeState?(.loaded(car))
                    case.failure(let error):
                        print(error)
                        self?.didChangeState?(.failed)
                }
            }
        }
    }
    
}
