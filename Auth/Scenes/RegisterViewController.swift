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

class RegisterViewController: UIViewController {
	weak var delegate: ViewControllerDelegate?
	private let viewModel: RegisterViewModel
	
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
	}
}
