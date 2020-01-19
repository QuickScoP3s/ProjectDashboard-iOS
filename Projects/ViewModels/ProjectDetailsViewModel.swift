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

class ProjectDetailsViewModel {
    private let networking: Networking
    private let database: AppDatabase
    private weak var coordinator: ProjectsCoordinator?
    
    private let projectId: Int
    var project: Project?

    init(projectId: Int, networking: Networking, database: AppDatabase, coordinator: ProjectsCoordinator) {
        self.projectId = projectId
        self.networking = networking
        self.database = database
        self.coordinator = coordinator
    }
    
    func fetchProject(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let projectRepo = ProjectRepository(networking: self.networking, database: self.database)
        
        projectRepo.getProject(byId: self.projectId) { result in
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
