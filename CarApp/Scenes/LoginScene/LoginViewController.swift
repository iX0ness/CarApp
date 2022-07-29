//
//  LoginViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModelType
    
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(LoginViewController.self) deinitialized")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
    }
}
