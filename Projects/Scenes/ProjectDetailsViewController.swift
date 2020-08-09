//
//  ProjectDetailsViewController.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {
    private let viewModel: ProjectDetailsViewModel
    
    @IBOutlet weak var txtProjectName: UILabel!
    @IBOutlet weak var txtTeamName: UILabel!
    
    @IBOutlet weak var txtContactName: UILabel!
    @IBOutlet weak var txtContactEmail: UILabel!
    @IBOutlet weak var txtContactPhone: UILabel!
    
    // MARK: Init
    
    init(viewModel: ProjectDetailsViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "ProjectDetailsView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Clean default texts
        updateInfo()
        viewModel.fetchProject() { result in
            switch result {
            case .failure(let error):
                print("😓 \(error.localizedDescription)")
            case .success:
                DispatchQueue.main.async {
                    self.updateInfo()
                }
            }
        }
    }
        
    private func updateInfo() {
        let project = viewModel.project
        let contact = project?.contactPerson
    }
}
