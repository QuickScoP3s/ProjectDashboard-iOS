//
//  ProjectsViewModel.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database
import Networking

class ProjectsViewModel: NSObject {
    private let networking: Networking
    private let database: AppDatabase
    private let userHelper: UserHelper
    private weak var coordinator: ProjectsCoordinator?
    
    var items: [Project]?

    init(networking: Networking, database: AppDatabase, userHelper: UserHelper, coordinator: ProjectsCoordinator) {
        self.networking = networking
        self.database = database
        self.userHelper = userHelper
        self.coordinator = coordinator
    }
    
    func fetchProjects(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let projectService = ProjectsService(networking: self.networking)
        
        projectService.getProjects() { result in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let items):
                let projects = items.map { $0.toModel() }
                self.items = projects
                
                completionHandler(Result.success(()))
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ProjectsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let project = items?[indexPath.row]
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellIdentifier")
        cell.textLabel?.text = project?.name
        cell.detailTextLabel?.text = "Team: Doe"
        return cell
    }
}

// MARK: - UITableViewDataSource

extension ProjectsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
