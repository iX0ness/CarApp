//
//  ViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 09/07/2022.
//

import UIKit

final class LoaderViewController: UIViewController {
    
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
        animateLogo()
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
    
    private func animateLogo() {
        let animationDistance = view.frame.width + imageView.bounds.width
        
        imageView.rotate360 { [weak self] in
            self?.imageView.moveRight(animationDistance, withDuration: 1.0, delay: 1.0)
        }
    }
}

