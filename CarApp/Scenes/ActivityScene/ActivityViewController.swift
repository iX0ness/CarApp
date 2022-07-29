//
//  ActivityViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class ActivityViewController: UIViewController {
    
    weak var coordinator: ActivityViewDelegate?
    private let viewModel: ActivityViewModelType
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: ActivityViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(ActivityViewController.self) deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func logout() {
        viewModel.logout()
    }
    
}

private extension ActivityViewController {
    func setupUI() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(logoutButton)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
    }
    
    enum Padding {
        static let logoutButtonWidthMultiplier: CGFloat = 0.35
        static let logoutButtonHeightMultiplier: CGFloat = 0.05
        static let logoutButtonBottomAnchor: CGFloat = -16
    }
}
