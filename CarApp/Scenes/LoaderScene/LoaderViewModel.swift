//
//  LoaderViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation
import FirebaseAuth

protocol LoaderViewModelType: AnyObject {
    func getAuthStatus(_ completion: @escaping (Bool) -> Void)
}

final class LoaderViewModel: LoaderViewModelType {
    func getAuthStatus(_ completion: @escaping (Bool) -> Void) {
        Auth.auth().addStateDidChangeListener { _, user in
            user == nil ? completion(false) : completion(true)
        }
    }
}
