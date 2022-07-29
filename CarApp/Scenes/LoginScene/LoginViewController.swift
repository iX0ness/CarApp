//
//  LoginViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class LoginViewController: UIViewController {
    
    weak var coordinator: LoginViewDelegate?
    private let viewModel: LoginViewModelType
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        
    @objc private func login() {
        viewModel.login { [weak self] result in
            switch result {
                case .success:
                    self?.coordinator?.didLogin()
                case .failure(let error):
                    print("error")
            }
        }
    }
    
}

private extension LoginViewController {
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(loginButton)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
    }
    
    enum Padding {
        static let logoutButtonWidthMultiplier: CGFloat = 0.35
        static let logoutButtonHeightMultiplier: CGFloat = 0.05
        static let logoutButtonBottomAnchor: CGFloat = -16
    }
}
