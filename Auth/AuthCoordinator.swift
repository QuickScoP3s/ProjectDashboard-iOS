//
//  AuthCoordinator.swift
//  Auth
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import Core

class AuthCoordinator: Coordinator {
    private let networking: Networking
    private let userHelper: UserHelper
    
    weak var parentViewController: UIViewController?
    weak var delegate: CoordinatorDelegate?
    
    private var navController = UINavigationController()
    var rootViewController: UIViewController {
        return navController
    }
    
    private lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel(networking: self.networking, userHelper: self.userHelper, coordinator: self)
    }()
    
    private lazy var registerViewModel: RegisterViewModel = {
        return RegisterViewModel(networking: self.networking, userHelper: self.userHelper, coordinator: self)
    }()
    
    init(networking: Networking, userHelper: UserHelper) {
        self.networking = networking
        self.userHelper = userHelper
    }
    
    func start() {
        let viewContoller = LoginViewController(viewModel: self.loginViewModel)
        viewContoller.delegate = self
        
        // Update to use correct root
        navController = UINavigationController(rootViewController: viewContoller)
        navController.modalPresentationStyle = .fullScreen
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isTranslucent = true
        
        parentViewController?.present(navController, animated: false)
    }
    
    func presentRegister() {
        let viewController = RegisterViewController(viewModel: self.registerViewModel)
        viewController.delegate = self
        
        navController.pushViewController(viewController, animated: true)
    }
}

// MARK: - ViewControllerDelegate

extension AuthCoordinator: ViewControllerDelegate {
    func close() {
        parentViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        delegate?.didFinish(coordintor: self)
    }
}
