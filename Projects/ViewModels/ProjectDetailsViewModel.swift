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

class ProjectDetailsViewModel {
    private let projectsService: ProjectsService
    private weak var coordinator: ProjectsCoordinator?
    
    private let projectId: Int
    var project: Project?

    init(projectId: Int, networking: Networking, coordinator: ProjectsCoordinator) {
        self.projectId = projectId
        
        self.projectsService = ProjectsService(networking: networking)
        self.coordinator = coordinator
    }
    
    func fetchProject(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        projectsService.getProject(byId: self.projectId) { result in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let item):
                self.project = item
                completionHandler(Result.success(()))
            }
        }
    }
}
