//
//  LoginViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol LoginViewModelType {
    func login(_ completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

final class LoginViewModel: LoginViewModelType {
    
    private let authorizationService: AuthorizationServiceType
    
    init(authorizationService: AuthorizationServiceType) {
        self.authorizationService = authorizationService
    }
    
    deinit {
        print("\(LoginViewModel.self) deinitialized")
    }
    
    func login(_ completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        authorizationService.login(completion: completion)
    }
}
