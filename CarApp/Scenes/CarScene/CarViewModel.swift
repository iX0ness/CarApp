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
    private var mediator: CarViewModelMediatorType
    
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
    
}
