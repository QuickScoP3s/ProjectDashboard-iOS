//
//  ProjectStats.swift
//  Core
//
//  Created by Waut Wyffels on 27/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

public struct ProjectStats: Codable {
	
	public let projectName: String
	public let teamName: String
	public let totalTasks: Int
	public let completedTasks: Int
	
}
