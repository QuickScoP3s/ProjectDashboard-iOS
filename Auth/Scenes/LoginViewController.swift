//
//  AuthViewController.swift
//  Auth
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import Core

class LoginViewController: UIViewController {
    weak var delegate: ViewControllerDelegate?
    private let viewModel: LoginViewModel
    
    // MARK: Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Login"
    }
    
    @objc func close() {
        delegate?.close()
    }
}
