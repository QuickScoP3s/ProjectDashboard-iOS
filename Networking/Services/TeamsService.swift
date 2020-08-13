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
	
	public init(networking: Networking) {
		self.networking = networking
	}
	
	// MARK: - API Calls
	
	public func getTeams(completion: @escaping ((Result<[Team], Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: baseUrl), completion: completion)
	}
	
	public func getTeam(byId id: Int, completion: @escaping ((Result<Team, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: "\(baseUrl)/\(id)"), completion: completion)
	}
	
	public func post(team dto: TeamDTO, completion: @escaping ((Result<Team, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: baseUrl, method: .post, body: dto), completion: completion)
	}
}
