//
//  Team.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

class Team {
    
    let id: Int
    var lead: User
    var members: [User]
    
    init(id: Int = 0, lead: User) {
        self.id = id
        self.lead = lead
        self.members = [User]()
    }
}
