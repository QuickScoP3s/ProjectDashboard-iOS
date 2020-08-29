//
//  RegisterDTO.swift
//  Core
//
//  Created by Waut Wyffels on 29/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

public struct RegisterDTO: Codable {
	
	public let firstName: String
	public let lastName: String
	public let email: String
	public let phoneNumber: String
	public let password: String
	public let passwordConfirm: String
	
	public init(firstName: String, lastName: String, email: String, phoneNr: String, password: String) {
		self.firstName = firstName
		self.lastName = lastName
		self.email = email
		self.phoneNumber = phoneNr
		self.password = password
		self.passwordConfirm = password
	}
	
}
