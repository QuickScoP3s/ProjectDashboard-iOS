//
//  StatsService.swift
//  Networking
//
//  Created by Waut Wyffels on 16/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core

public class StatsService: BaseService {
	
	public init(networking: Networking) {
		super.init(baseUrl: "stats", networking: networking)
	}
	
	// MARK: - API Calls
	
	public func getStats(completion: @escaping ((Result<UserStats, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: baseUrl), completion: completion)
	}
	
	public func getStats(forProjectId projectId: Int, completion: @escaping ((Result<ProjectStats, Error>) -> Void)) {
		networking.getJSONResult(from: Request(url: "\(baseUrl)/project/\(projectId)"), completion: completion)
	}
}
