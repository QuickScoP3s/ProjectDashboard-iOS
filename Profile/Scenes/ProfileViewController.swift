//
//  ProfileViewController.swift
//  Profile
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

class ProfileViewController: UIViewController {
    weak var delegate: ViewControllerDelegate?
    private let viewModel: ProfileViewModel
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var btnSignOut: UIButton!
    
    // MARK: Init
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "ProfileView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        imgProfile.image = UIImage(named: "Profile")
        imgProfile.layer.borderColor = UIColor.systemIndigo.cgColor
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.cornerRadius = 50.0 / 2
        
        let username = viewModel.userName
        let email = viewModel.userEmail
        
        txtName.text = username
        txtEmail.text = email
        
        btnSignOut.addTarget(viewModel, action: #selector(viewModel.signOut), for: .touchUpInside)
    }
}
