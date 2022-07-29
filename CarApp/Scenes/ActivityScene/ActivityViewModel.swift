//
//  ActivityViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol ActivityViewModelType: AnyObject {
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

final class ActivityViewModel: ActivityViewModelType {
    
    private let logoutService: LogoutServiceType
    
    init(logoutService: LogoutServiceType) {
        self.logoutService = logoutService
    }
    
    deinit {
        print("\(ActivityViewModel.self) deinitialized")
    }
    
    func logout(completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        logoutService.logout(completion: completion)
    }
    
}
