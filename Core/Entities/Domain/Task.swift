//
//  Task.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

class Task {
    
    let id: Int
    var name: String
    var steps: [String]
    var assignedTo: User
    
    init(id: Int = 0, name: String, assignedTo: User) {
        self.id = id
        self.name = name
        self.steps = [String]()
        self.assignedTo = assignedTo
    }
}
