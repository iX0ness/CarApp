//
//  LogoutService.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation
import FirebaseAuth

protocol LogoutServiceType: AnyObject {
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

final class LogoutService: LogoutServiceType {
    
    private let email = "leznevo@gmail.com"
    private let passwrod = "123456"
    
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.signoutFailed))
        }
    }
}
