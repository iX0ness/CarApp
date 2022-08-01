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
    
    func makeCarViewController(logoutService: LogoutServiceType, mediator: CarViewModelMediatorType) -> CarViewController {
        let viewModel = makeCarViewModel(logoutService: logoutService, mediator: mediator)
        return CarViewController(viewModel: viewModel)
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
    
    func makeCarViewModel(logoutService: LogoutServiceType, mediator: CarViewModelMediatorType) -> CarViewModel {
        .init(logoutService: logoutService, mediator: mediator)
    }
    
    func makeKilometrageCorrectorViewModel() -> KilometrageCorrectorViewModel {
        .init()
    }
}
