//
//  KilometrageCorrectorViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class KilometrageCorrectorViewController: UIViewController {
    
    private lazy var carDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            modelLabel,
            doorsLabel,
            kilometrageLabel,
            vinLabel,
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.text = "Model"
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doorsLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kilometrageLabel: UILabel = {
        let label = UILabel()
        label.text = "144555"
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vinLabel: UILabel = {
        let label = UILabel()
        label.text = "GHY6-ZX21-B6U8-RFX2"
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 9999999999
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .touchUpInside)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private let viewModel: KilometrageCorrectorViewModelType
    
    init(viewModel: KilometrageCorrectorViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        print("Stepper value: \(sender.value)")
    }
}

private extension KilometrageCorrectorViewController {
    func setupUI() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(carDataStackView)
        view.addSubview(stepper)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            carDataStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            carDataStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            carDataStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            carDataStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: carDataStackView.bottomAnchor, constant: 16),
            stepper.centerXAnchor.constraint(equalTo: carDataStackView.centerXAnchor),
            
        ])
    }
}
