//
//  LoginDTO.swift
//  Core
//
//  Created by Waut Wyffels on 17/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

public struct LoginDTO: Codable {
	
	public let email: String
	public let password: String
	
	public init(email: String, password: String) {
		self.email = email
		self.password = password
	}
}
