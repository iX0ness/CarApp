//
//  AuthorizationService.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 14/07/2022.
//

import Foundation
import Combine

final class AuthorizationService {
    var authState: AnyPublisher<Bool, Error> {
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
