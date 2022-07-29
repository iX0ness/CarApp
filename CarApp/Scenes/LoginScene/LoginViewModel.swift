//
//  LoginViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol LoginViewModelType {
    func login(_ completion: Result<Void, Error>)
}

final class LoginViewModel: LoginViewModelType {
    func login(_ completion: Result<Void, Error>) {}
    
    deinit {
        print("\(LoginViewModel.self) deinitialized")
    }
}
