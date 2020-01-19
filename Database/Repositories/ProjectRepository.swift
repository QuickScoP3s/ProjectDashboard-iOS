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
    
    public init(networking: Networking, database: AppDatabase) {
        self.projectsService = ProjectsService(networking: networking)
        self.teamsService = TeamsService(networking: networking)
        
        self.projectDao = database.projectDao
        self.teamsDao = database.teamsDao
    }
    
    public func getProjects(completionHandler: @escaping ((Result<[Project], Error>) -> Void)) {
        teamsService.getTeams() { teamResult in
            switch teamResult {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let teams):
                self.projectsService.getProjects() { result in
                    switch result {
                    case .failure(let error):
                        completionHandler(Result.failure(error))
                    case .success(let items):
                        var projects = items.map { $0.toModel() }
                        
                        //do {
                        //    try self.projectDao.insertAll(items: projects)
                        //} catch (let error) {
                        //    print(error)
                        //}
                        //
                        //guard var res = try? self.projectDao.getAll() else {
                        //    completionHandler(Result.success([]))
                        //    return
                        //}
                        
                        for (i, _) in projects.enumerated() {
                            var proj = projects[i]
                            proj.team = teams.first(where: { $0.id == proj.teamId })
                            
                            projects[i] = proj
                        }
                        
                        completionHandler(Result.success(projects))
                    }
                }
            }
        }
    }
    
    public func getProject(byId id: Int, completionHandler: @escaping ((Result<Project, Error>) -> Void)) {
        teamsService.getTeams() { teamResult in
            switch teamResult {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let teams):
                self.projectsService.getProject(byId: id) { result in
                    switch result {
                    case .failure(let error):
                        completionHandler(Result.failure(error))
                    case .success(let item):
                        var project = item.toModel()
                        project.team = teams.first(where: { $0.id == project.teamId })
                        
                        completionHandler(Result.success(project))
                    }
                }
            }
        }
    }
}
