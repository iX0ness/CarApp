//
//  CarViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol CarViewModelType: AnyObject {
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

final class CarViewModel: CarViewModelType {
    
    private let logoutService: LogoutServiceType
    
    init(logoutService: LogoutServiceType) {
        self.logoutService = logoutService
    }
    
    deinit {
        print("\(CarViewModel.self) deinitialized")
    }
    
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        logoutService.logout(completion: completion)
    }
    
}
