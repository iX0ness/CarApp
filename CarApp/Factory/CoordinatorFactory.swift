//
//  CoordinatorFactory.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation
import UIKit

final class CoordinatorFactory {
    func makeAuthCoordinator() -> AuthCoordinator {
        .init()
    }
    
    func makeMainCoordinator() -> MainCoordinator {
        .init()
    }
}
