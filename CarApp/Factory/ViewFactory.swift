//
//  ViewFactory.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 16/07/2022.
//

import Foundation

final class ViewFactory {
    func makeLoaderViewController() -> LoaderViewController {
        return LoaderViewController(viewModel: makeLoaderViewModel())
    }
    
    func makeLoginViewController(authorizationService: AuthorizationServiceType) -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel(authorizationService: authorizationService))
    }
    
    func makeCarViewController(logoutService: LogoutServiceType) -> CarViewController {
        return CarViewController(viewModel: makeCarViewModel(logoutService: logoutService))
    }
    
    func makeKilometrageCorrectorViewcontroller() -> KilometrageCorrectorViewController {
        return KilometrageCorrectorViewController(viewModel: makeKilometrageCorrectorViewModel())
    }
}

private extension ViewFactory {
    func makeLoaderViewModel() -> LoaderViewModel {
        .init()
    }
    
    func makeLoginViewModel(authorizationService: AuthorizationServiceType) -> LoginViewModel {
        .init(authorizationService: authorizationService)
    }
    
    func makeCarViewModel(logoutService: LogoutServiceType) -> CarViewModel {
        .init(logoutService: logoutService)
    }
    
    func makeKilometrageCorrectorViewModel() -> KilometrageCorrectorViewModel {
        .init()
    }
}
