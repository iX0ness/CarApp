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
    
    init(viewModel: ActivityViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
