//
//  ContractInfo.swift
//  Core
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

public struct ContactInfo: Codable {
	
	public let firstName: String
	public let lastName: String
	public let email: String
	public let phoneNumber: String
	
	public init(firstName: String, lastName: String, email: String, phoneNumber: String) {
		self.firstName = firstName
		self.lastName = lastName
		self.email = email
		self.phoneNumber = phoneNumber
	}
}
