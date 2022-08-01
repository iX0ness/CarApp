//
//  CarViewController.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import UIKit

final class CarViewController: UIViewController {
    
    weak var coordinator: CarViewDelegate?
    private let viewModel: CarViewModelType
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
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
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doorsLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kilometrageLabel: UILabel = {
        let label = UILabel()
        label.text = "144555"
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vinLabel: UILabel = {
        let label = UILabel()
        label.text = "GHY6-ZX21-B6U8-RFX2"
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fetchCarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch car", for: .normal)
        button.addTarget(self, action: #selector(fetchCar), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let kilometrageCorrectorViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kilometrage corrector view", for: .normal)
        button.addTarget(self, action: #selector(openKilometrageCorrectorView), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: CarViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(CarViewController.self) deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bind()
        viewModel.fetchCar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func fetchCar() {
        viewModel.fetchCar()
    }
    
    @objc private func openKilometrageCorrectorView() {
        guard let car = viewModel.car else { return }
        self.coordinator?.showKilometrageCorrectorView(for: car)
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
    
    private func bind() {
        viewModel.didChangeState = { [weak self] state in
            switch state {
                case .loading:
                    self?.showActivityIndicator()
                    self?.hideLabels()
                case .loaded(let car):
                    self?.hideActivityIndicator()
                    self?.showCarView(car)
                case .failed:
                    self?.hideActivityIndicator()
                    self?.showFailureView()
            }
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func showFailureView() {
        modelLabel.text = "Failed to load car data"
        modelLabel.alpha = 1
    }
    
    func showCarView(_ car: Car) {
        modelLabel.text = car.model
        doorsLabel.text = String(car.doors)
        kilometrageLabel.text = String(car.kilometrage)
        vinLabel.text = car.vin
        
        modelLabel.alpha = 1
        doorsLabel.alpha = 1
        kilometrageLabel.alpha = 1
        vinLabel.alpha = 1
    }
    
    private func hideLabels() {
        modelLabel.alpha = 0
        doorsLabel.alpha = 0
        kilometrageLabel.alpha = 0
        vinLabel.alpha = 0
    }
    
}

private extension CarViewController {
    func setupUI() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        view.addSubview(carDataStackView)
        view.addSubview(fetchCarButton)
        view.addSubview(kilometrageCorrectorViewButton)
        view.addSubview(logoutButton)
        view.addSubview(activityIndicator)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            carDataStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            carDataStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            carDataStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            carDataStackView.bottomAnchor.constraint(lessThanOrEqualTo: fetchCarButton.topAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            fetchCarButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            fetchCarButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            fetchCarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchCarButton.bottomAnchor.constraint(equalTo: kilometrageCorrectorViewButton.topAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            kilometrageCorrectorViewButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            kilometrageCorrectorViewButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            kilometrageCorrectorViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kilometrageCorrectorViewButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: Padding.logoutButtonWidthMultiplier),
            logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Padding.logoutButtonHeightMultiplier),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: Padding.logoutButtonBottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    enum Padding {
        static let logoutButtonWidthMultiplier: CGFloat = 0.8
        static let logoutButtonHeightMultiplier: CGFloat = 0.05
        static let logoutButtonBottomAnchor: CGFloat = -16
    }
}
