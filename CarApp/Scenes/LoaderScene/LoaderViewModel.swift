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
    func removeStateListener()
}

final class LoaderViewModel: LoaderViewModelType {
    
    private var listenerHander: AuthStateDidChangeListenerHandle?
    
    func getAuthStatus(_ completion: @escaping (Bool) -> Void) {
        listenerHander = Auth.auth().addStateDidChangeListener { authResult, user in
            user == nil ? completion(false) : completion(true)
        }
    }
    
    func removeStateListener() {
        if let listener = listenerHander {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
}
