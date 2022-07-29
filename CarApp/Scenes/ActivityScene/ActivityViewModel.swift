//
//  ActivityViewModel.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

protocol ActivityViewModelType: AnyObject {
    func logout()
}

final class ActivityViewModel: ActivityViewModelType {
    
    deinit {
        print("\(ActivityViewModel.self) deinitialized")
    }
    
    func logout() {}
}
