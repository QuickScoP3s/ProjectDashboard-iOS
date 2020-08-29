//
//  RegisterViewController.swift
//  Auth
//
//  Created by Waut Wyffels on 17/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Components
import LPSnackbar

class RegisterViewController: UIViewController {
	
	private let viewModel: RegisterViewModel
	weak var delegate: ViewControllerDelegate?
	
	@IBOutlet weak var txtFirstNameField: UITextField!
	@IBOutlet weak var txtLastNameField: UITextField!
	@IBOutlet weak var txtEmailField: UITextField!
	@IBOutlet weak var txtPhoneField: UITextField!
	@IBOutlet weak var txtPasswordField: UITextField!
	
	@IBOutlet weak var btnSignUp: UIButton!
	
	// MARK: Init
	
	init(viewModel: RegisterViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "RegisterView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Register"
		
		btnSignUp.setBackgroundColor(color: .gray, forState: .disabled)
		btnSignUp.addTarget(self, action: #selector(signUp), for: .touchUpInside)
		
		txtPasswordField.isSecureTextEntry = true
		txtPasswordField.textContentType = .oneTimeCode
		
		[txtFirstNameField, txtLastNameField, txtEmailField, txtPasswordField]
			.forEach({ $0?.addTarget(self, action: #selector(detailsChanged), for: .editingChanged) })
	}
	
	@objc func detailsChanged(_ textField: UITextField) {
		guard
			let firstName = txtFirstNameField.text, !firstName.isEmpty,
			let lastName = txtLastNameField.text, !lastName.isEmpty,
			let email = txtEmailField.text, !email.isEmpty,
			let phone = txtPhoneField.text, !phone.isEmpty,
			let password = txtPasswordField.text, !password.isEmpty
			else {
				btnSignUp.isEnabled = false
				return
		}
		
		btnSignUp.isEnabled = true
	}
	
	@objc func signUp() {
		let firstName = txtFirstNameField.text ?? ""
		let lastName = txtLastNameField.text ?? ""
		let email = txtEmailField.text ?? ""
		let phone = txtPhoneField.text ?? ""
		let password = txtPasswordField.text ?? ""
	
		viewModel.register(firstName: firstName,
								 lastName: lastName,
								 email: email,
								 phone: phone,
								 password: password) { result in
			switch result {
				case .failure(_):
					LPSnackbar.showSnack(title: "Registration failed, check details", displayDuration: 1.0)
				case .success():
					self.delegate?.close()
			}
		}
	}
}
