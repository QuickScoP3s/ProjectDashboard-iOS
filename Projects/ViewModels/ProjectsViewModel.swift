//
//  ProjectsViewModel.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking

class ProjectsViewModel: NSObject {
    
    private let projectsService: ProjectsService
    private let userHelper: UserHelper
    private weak var coordinator: ProjectsCoordinator?
    
    var items: [Project]?

    init(networking: Networking, userHelper: UserHelper, coordinator: ProjectsCoordinator) {
        self.userHelper = userHelper
        self.coordinator = coordinator
        
        self.projectsService = ProjectsService(networking: networking)
    }
    
    func fetchProjects(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        projectsService.getProjects() { result in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let items):
                self.items = items
                completionHandler(Result.success(()))
            }
        }
    }
    
    @objc func addProject() {
        coordinator?.presentAddProject()
    }
}

// MARK: - UITableViewDataSource

extension ProjectsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let project = items?[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ProjectCell")
        }
        
        cell!.textLabel?.text = project?.name
        cell!.detailTextLabel?.text = "Team: \(project?.team.name ?? "")"
        
        return cell!
    }
}

// MARK: - UITableViewDataSource

extension ProjectsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let project = items![indexPath.row]
        coordinator?.presentDetails(projectId: project.id)
    }
}
