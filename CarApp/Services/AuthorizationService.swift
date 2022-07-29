//
//  AuthorizationService.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation
import FirebaseAuth

enum AuthorizationError: Error {
    case authorizationFailed
    case signoutFailed
}

protocol AuthorizationServiceType: AnyObject {
    func login(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

final class AuthorizationService: AuthorizationServiceType {
    
    private let email = "leznevo@gmail.com"
    private let passwrod = "123456"
    
    func login(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: passwrod) { authResult, error in
            if error != nil {
                completion(.failure(.authorizationFailed))
                return
            }
            
            if authResult?.user == nil {
                completion(.failure(.authorizationFailed))
                return
            }
            
            completion(.success(()))
        }
    }
}
