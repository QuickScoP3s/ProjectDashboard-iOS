//
//  Task.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

public class ProjectTask: Codable {
    
    //TODO Change to new Domain Models
    
    public let id: Int
    public let title: String
    public let description: String
    public let assignee: User?
    
    init(id: Int = 0, title: String, description: String, assignee: User? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.assignee = assignee
    }
}
