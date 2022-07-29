//
//  LoaderViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 09/07/2022.
//

import UIKit

final class LoaderViewController: UIViewController {
    
    private let viewModel: LoaderViewModelType
    weak var coordinator: LoaderViewDelegate?
    
    init(viewModel: LoaderViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.Images.launch))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rotateLogo { [weak self] in
            self?.checkAuthorizationStatus(
                onAuthorized: {
                    self?.moveLogo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.coordinator?.runMainFlow()
                    }
                },
                onUnAuthrized: {
                    self?.coordinator?.runAuthFlow()
                })
        }
    }
    
    private func setupLogo() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            imageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }
    
    
    
    func rotateLogo(_ completion: @escaping () -> Void) {
        imageView.rotate360(completion)
    }
    
    func moveLogo() {
        let animationDistance = view.frame.width + imageView.bounds.width
        
        imageView.moveRight(animationDistance, withDuration: 1.0)
    }
    
    func checkAuthorizationStatus( onAuthorized: @escaping () -> Void, onUnAuthrized: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewModel.getAuthStatus { isAuthrozed in
                if isAuthrozed {
                    self?.coordinator?.runMainFlow()
                } else {
                    self?.coordinator?.runAuthFlow()
                }
            }
        }
    }
}

