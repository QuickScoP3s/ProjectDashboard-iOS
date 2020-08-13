//
//  ProjectsService.swift
//  Networking
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core
import Utils

public class ProjectsService {
	
	private let baseUrl = "projects"
	private let networking: Networking
	
	public init(networking: Networking) {
		self.networking = networking
	}
	
	// MARK: - API Calls
	
	public func getProjects(completion: @escaping ((Result<[Project], Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: baseUrl), completion: completion)
	}
	
	public func getProject(byId id: Int, completion: @escaping ((Result<Project, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: "\(baseUrl)/\(id)"), completion: completion)
	}
	
	public func getTasks(forProjectId id: Int, completion: @escaping ((Result<[ProjectTask], Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: "\(baseUrl)/\(id)/tasks"), completion: completion)
	}
	
	public func post(project dto: ProjectDTO, completion: @escaping ((Result<Project, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: baseUrl, method: .post, body: dto), completion: completion)
	}
}
