//
//  ProjectsService.swift
//  Networking
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core

public class TeamsService {
    private let baseUrl = "teams"
    private let networking: Networking
    
    private let jsonDecoder: JSONDecoder
    
    public init(networking: Networking) {
        self.networking = networking
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    }
    
    // MARK: - API Calls
    
    public func getTeams(completionHandler: @escaping ((Result<[Team], Error>) -> Void)) {
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
                    let response = try self.jsonDecoder.decode([Team].self, from: data)
                    completionHandler(Result.success(response))
                }
                catch let error {
                    completionHandler(Result.failure(error))
                }
            }
        }
    }
    
    public func getTeamById(id: Int, completionHandler: @escaping ((Result<Team, Error>) -> Void)) {
        let request = Request(url: "\(baseUrl)/\(id)", method: .get)
        
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
                    let response = try self.jsonDecoder.decode(Team.self, from: data)
                    completionHandler(Result.success(response))
                }
                catch let error {
                    completionHandler(Result.failure(error))
                }
            }
        }
    }
    
    public func postTeam(_ team: TeamDTO, completionHandler: @escaping ((Result<Team, Error>) -> Void)) {
        let request = Request(url: baseUrl, method: .post, body: team)
        
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
                    let response = try self.jsonDecoder.decode(Team.self, from: data)
                    completionHandler(Result.success(response))
                }
                catch let error {
                    completionHandler(Result.failure(error))
                }
            }
        }
    }
}
