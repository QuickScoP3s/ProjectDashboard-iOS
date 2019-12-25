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
    private var childCoordinators: [Coordinator] = []
    private weak var rootViewController: UIViewController?
    weak var delegate: CoordinatorDelegate?
    
    private var navController: UINavigationController?
    
    init(networking: Networking, rootViewController: UIViewController?) {
        self.networking = networking
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = LoginViewModel(networking: networking, coordinator: self)
        let viewContoller = LoginViewController(viewModel: viewModel)
        viewContoller.delegate = self
        
        navController = UINavigationController(rootViewController: viewContoller)
        navController?.modalPresentationStyle = .fullScreen
        navController?.navigationBar.prefersLargeTitles = true
        navController?.navigationBar.isTranslucent = true
        rootViewController?.present(navController!, animated: true, completion: nil)
    }
    
    func presentRegister() {
        
    }
    
    func backToLogin() {
        
    }
}

// MARK: - ControllerDelegates

extension AuthCoordinator: ViewControllerDelegate {
    func close() {
        rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        delegate?.didFinish(coordintor: self)
    }
}
