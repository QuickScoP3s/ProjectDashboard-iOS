//
//  Project.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 22/10/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

class Project {
    
    let id: Int
    let team: Team
    let tasks: [Task]
    let lastEdited: Date
    let owner: Company
    let contact: User
    
    init(id: Int = 0, team: Team, lastEdited: Date, owner: Company, contact: User) {
        self.id = id
        self.team = team
        self.tasks = [Task]()
        self.lastEdited = lastEdited
        self.owner = owner
        self.contact = contact
    }
    
    convenience init(team: Team, owner: Company, contact: User) {
        self.init(team: team, lastEdited: Date(), owner: owner, contact: contact)
    }
}
