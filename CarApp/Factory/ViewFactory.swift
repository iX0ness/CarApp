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
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }
}

private extension ViewFactory {
    func makeLoaderViewModel() -> LoaderViewModel {
        .init()
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        .init()
    }
}
