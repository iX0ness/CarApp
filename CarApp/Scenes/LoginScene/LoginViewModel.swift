//
//  LoginViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol LoginViewModelType {
    func login(_ completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginViewModel: LoginViewModelType {
    
    deinit {
        print("\(LoginViewModel.self) deinitialized")
    }
    
    func login(_ completion: @escaping (Result<Void, Error>) -> Void) {}
}
