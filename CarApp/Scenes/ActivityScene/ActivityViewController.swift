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
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityModifyViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Modify activity view", for: .normal)
        button.addTarget(self, action: #selector(openModifyActivityView), for: .touchUpInside)
        button.backgroundColor = .lightGray
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
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func logout() {
        viewModel.logout { [weak self] result in
            switch result {
                case .success:
                    self?.coordinator?.logout()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @objc private func openModifyActivityView() {
        self.coordinator?.showActivityModifyView()
    }
    
}

private extension ActivityViewController {
    func setupUI() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(logoutButton)
        view.addSubview(activityModifyViewButton)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            activityModifyViewButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            activityModifyViewButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            activityModifyViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityModifyViewButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
    }
    
    enum Padding {
        static let logoutButtonWidthMultiplier: CGFloat = 0.5
        static let logoutButtonHeightMultiplier: CGFloat = 0.05
        static let logoutButtonBottomAnchor: CGFloat = -16
    }
}
