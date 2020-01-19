//
//  ProjectRepository.swift
//  Database
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core
import Networking

public class ProjectRepository {
    private let projectsService: ProjectsService
    private let teamsService: TeamsService
    
    private let projectDao: ProjectsDAO
    private let teamsDao: TeamsDAO
    
    init(networking: Networking, database: AppDatabase) {
        self.projectsService = ProjectsService(networking: networking)
        self.teamsService = TeamsService(networking: networking)
        
        self.projectDao = database.projectDao
        self.teamsDao = database.teamsDao
    }
}
