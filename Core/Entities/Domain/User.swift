//
//  User.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 22/10/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

class User {
    
    let id: Int
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var company: Company
    
    init(id: Int = 0, firstName: String, lastName: String, email: String, phoneNr: String, company: Company) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNr
        self.company = company
    }
}
