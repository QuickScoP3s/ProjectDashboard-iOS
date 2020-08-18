//
//  UserStats.swift
//  Core
//
//  Created by Waut Wyffels on 16/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

public struct UserStats: Codable {
	
	public let projects: Int
	public let teams: Int
	public let assignedTasks: Int
	public let tasksInProgress: Int
	public let completedTasks: Int
	
}
