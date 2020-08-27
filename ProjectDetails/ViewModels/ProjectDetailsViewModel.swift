//
//  ProjectDetailsViewModel.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 26/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core
import Networking

class ProjectDetailsViewModel: NSObject {
	
	let projectId: Int
	private let statsService: StatsService
	
	init(projectId: Int, networking: Networking) {
		self.projectId = projectId
		self.statsService = StatsService(networking: networking)
	}
	
	func fetchDetails(completion: @escaping ((Result<ProjectStats, Error>) -> Void)) {
		self.statsService.getStats(forProjectId: self.projectId, completion: completion)
	}
}
