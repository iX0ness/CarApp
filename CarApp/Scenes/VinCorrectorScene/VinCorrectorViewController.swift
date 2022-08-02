//
//  VinCorrectorViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 01/08/2022.
//

import UIKit

final class VinCorrectorViewController: UIViewController {
    
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
    
    private let vinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "VIN"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addDoneButtonOnKeyboard()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let viewModel: VinCorrectorViewModelType
    
    init(viewModel: VinCorrectorViewModelType) {
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
        bind()
        viewModel.viewDidLoad() { [weak self] vin in
            self?.vinTextField.text = vin
        }
        vinTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func bind() {
        viewModel.didCarUpdate = { [weak self] car in
            self?.configure(with: car)
        }
    }
    
    private func configure(with car: Car) {
        modelLabel.text = car.model
        doorsLabel.text = String(car.doors)
        kilometrageLabel.text = String(car.kilometrage)
        vinLabel.text = car.vin
    }
    
}

private extension VinCorrectorViewController {
    func setupUI() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(carDataStackView)
        view.addSubview(vinTextField)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            carDataStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            carDataStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            carDataStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            carDataStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            vinTextField.topAnchor.constraint(equalTo: carDataStackView.bottomAnchor, constant: 16),
            vinTextField.centerXAnchor.constraint(equalTo: carDataStackView.centerXAnchor),
            vinTextField.widthAnchor.constraint(equalTo: carDataStackView.widthAnchor, multiplier: 0.8),
        ])
    }
}


extension VinCorrectorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.set(vin: textField.text) { vin in
            vinTextField.text = vin
        }
    }
}
