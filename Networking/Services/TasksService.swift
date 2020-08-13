//
//  TasksService.swift
//  Networking
//
//  Created by Waut Wyffels on 11/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core
import Alamofire

public class TasksService {
	
	private let baseUrl = "tasks"
	private let networking: Networking
	
	public init(networking: Networking) {
		self.networking = networking
	}
	
	// MARK: - API Calls
	
	public func getTask(byId id: Int, completion: @escaping ((Result<ProjectTask, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: "\(baseUrl)/\(id)"), completion: completion)
	}
	
	public func post(task dto: ProjectTaskDTO, completion: @escaping ((Result<ProjectTask, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: baseUrl, method: .post, body: dto), completion: completion)
	}
	
	public func put(task dto: ProjectTaskDTO, withId id: Int, completion: @escaping ((Result<Void, Error>) -> Void)) {
		networking.executeWithoutResult(request: Request(url: "\(baseUrl)/\(id)", method: .put, body: dto), completion: completion)
	}
	
	public func put(status: Bool, forId id: Int, completion: @escaping ((Result<Void, Error>) -> Void)) {
		let request = Request(url: "\(baseUrl)/\(id)/set-status", method: .put, parameters: ["completed": status])
		networking.executeWithoutResult(request: request, completion: completion)
	}
	
	public func deleteTask(byId id: Int, completion: @escaping ((Result<ProjectTask, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: "\(baseUrl)/\(id)", method: .delete), completion: completion)
	}
}
