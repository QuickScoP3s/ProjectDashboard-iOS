//
//  Task.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

public class ProjectTask: Codable {
    
    public let title: String
    public let description: String
    
    public init(title: String, description: String = "") {
        self.title = title
        self.description = description
    }
}
