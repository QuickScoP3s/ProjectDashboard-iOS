//
//  AuthViewController.swift
//  Auth
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import Core
import Components
import LPSnackbar
import Utils

class LoginViewController: UIViewController {
    weak var delegate: ViewControllerDelegate?
    private let viewModel: LoginViewModel
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtEmailField: UITextField!
    @IBOutlet weak var txtPasswordField: UITextField!
    
    // MARK: Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "LoginView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        navigationItem.title = "Login"
        
        // Load image from MAIN bundle (Project assets)
        iconView.image = UIImage(named: "Icon")
        
        btnLogin.addTarget(self, action: #selector(login), for: .touchUpInside)
        btnLogin.setBackgroundColor(color: .gray, forState: .disabled)
        
        btnRegister.addTarget(viewModel, action: #selector(viewModel.register), for: .touchUpInside)
        
        [txtEmailField, txtPasswordField].forEach({ $0?.addTarget(self, action: #selector(credentialsChanged), for: .editingChanged) })
    }
    
    @objc
    func credentialsChanged(_ textField: UITextField) {
        guard
            let email = txtEmailField.text, !email.isEmpty,
            let password = txtPasswordField.text, !password.isEmpty
        else {
            btnLogin.isEnabled = false
            return
        }
        
        btnLogin.isEnabled = true
    }
    
    @objc
    func login() {
        let email = txtEmailField.text ?? ""
        let password = txtPasswordField.text ?? ""
        
        viewModel.login(email: email, password: password) { result in
            switch result {
            case .failure(_):
                LPSnackbar.showSnack(title: "Login failed, check credentials", displayDuration: 1.0)
            case .success():
                self.delegate?.close()
            }
        }
    }
}
