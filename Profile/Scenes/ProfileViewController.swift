//
//  ProfileViewController.swift
//  Profile
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    private let viewModel: ProfileViewModel
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
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
        
        navigationItem.title = "Profile"
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Image should be loaded from UserHelper (Too little time)
        imgProfile.image = UIImage(named: "Profile")
        imgProfile.layer.borderColor = UIColor.systemIndigo.cgColor
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.cornerRadius = 75.0 / 2
        
        txtName.text = viewModel.userName
        txtEmail.text = viewModel.userEmail
    }
}
