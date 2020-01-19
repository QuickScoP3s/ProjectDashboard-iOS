//
//  ProjectsService.swift
//  Networking
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core

public class ProjectsService {
    private let baseUrl = "projects"
    private let networking: Networking
    
    public init(networking: Networking) {
        self.networking = networking
    }
    
    // MARK: - API Calls
    
    public func getProjects(completionHandler: @escaping ((Result<[ProjectDTO], Error>) -> Void)) {
        let request = Request(url: baseUrl, method: .get)
        
        networking.execute(request: request) { result in
            switch result {
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    completionHandler(Result.failure(error))

                case .success(let response):
                    guard let data = response?.data else {
                        return
                    }
                    
                    do {
                        let response = try JSONDecoder().decode([ProjectDTO].self, from: data)
                        completionHandler(Result.success(response))
                    }
                    catch let error {
                        completionHandler(Result.failure(error))
                    }
            }
        }
    }
    
    public func getProjectById(id: Int, completionHandler: @escaping ((Result<ProjectDTO, Error>) -> Void)) {
        let request = Request(url: baseUrl, method: .get, urlParameters: [ "id": id ])
        
        networking.execute(request: request) { result in
            switch result {
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    completionHandler(Result.failure(error))

                case .success(let response):
                    guard let data = response?.data else {
                        return
                    }
                    
                    do {
                        let response = try JSONDecoder().decode(ProjectDTO.self, from: data)
                        completionHandler(Result.success(response))
                    }
                    catch let error {
                        completionHandler(Result.failure(error))
                    }
            }
        }
    }
}
