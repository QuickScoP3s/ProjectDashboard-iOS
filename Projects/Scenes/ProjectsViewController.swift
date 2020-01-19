//
//  TeamsViewController.swift
//  Teams
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
    private let viewModel: ProjectsViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Init
    
    init(viewModel: ProjectsViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "ProjectsView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Projects"
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        viewModel.fetchProjects() { result in
            switch result {
            case .failure(let error):
                print("😓 \(error.localizedDescription)")
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
