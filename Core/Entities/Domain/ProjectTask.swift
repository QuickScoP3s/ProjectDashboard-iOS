//
//  Task.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

public class ProjectTask: Codable {
	
	public let id: Int
	public let title: String
	public let description: String
	
	public let assigneeId: Int?
	public let assignee: User?
	
	public var isCompleted: Bool
}
