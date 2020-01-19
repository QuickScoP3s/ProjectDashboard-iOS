//
//  TeamsViewController.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController {
    private let viewModel: TeamsViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Init
    
    init(viewModel: TeamsViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "TeamsView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Overview"
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        viewModel.fetchTeams() { result in
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
