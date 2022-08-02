//
//  KilometrageCorrectorViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class KilometrageCorrectorViewController: UIViewController {
    
    weak var coordinator: KilometrageCorrectorViewControllerDelegate?
    
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
    
    private let vinCorrectorViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Vin Corrector View", for: .normal)
        button.addTarget(self, action: #selector(openVinCorrectorView), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel: KilometrageCorrectorViewModelType
    
    init(viewModel: KilometrageCorrectorViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(KilometrageCorrectorViewController.self) deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bind()
        viewModel.viewDidLoad() { [weak self] value in
            self?.stepper.value = Double(value)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        viewModel.changeKilometrage(to: Int(sender.value))
    }
    
    @objc private func openVinCorrectorView() {
        coordinator?.showVinCorrectorView(for: viewModel.car)
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

private extension KilometrageCorrectorViewController {
    func setupUI() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(carDataStackView)
        view.addSubview(stepper)
        view.addSubview(vinCorrectorViewButton)
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
        
        NSLayoutConstraint.activate([
            vinCorrectorViewButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
            vinCorrectorViewButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            vinCorrectorViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vinCorrectorViewButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16),
        ])
    }
}
