//
//  Company.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

class Company {
    
    let id: Int
    var name: String
    var address: String
    
    init(id: Int = 0, name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}
