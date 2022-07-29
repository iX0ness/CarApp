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
    
    func makeActivityViewController(logoutService: LogoutServiceType) -> ActivityViewController {
        return ActivityViewController(viewModel: makeActivityViewModel(logoutService: logoutService))
    }
    
    func makeActivityModifyViewcontroller() -> ModifyActivityViewController {
        return ModifyActivityViewController(viewModel: makeModifyActivityViewModel())
    }
}

private extension ViewFactory {
    func makeLoaderViewModel() -> LoaderViewModel {
        .init()
    }
    
    func makeLoginViewModel(authorizationService: AuthorizationServiceType) -> LoginViewModel {
        .init(authorizationService: authorizationService)
    }
    
    func makeActivityViewModel(logoutService: LogoutServiceType) -> ActivityViewModel {
        .init(logoutService: logoutService)
    }
    
    func makeModifyActivityViewModel() -> ModifyActivityViewModel {
        .init()
    }
}
