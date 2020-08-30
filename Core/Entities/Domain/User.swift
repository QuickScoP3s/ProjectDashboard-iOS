//
//  User.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 22/10/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit

public struct User: Codable {
	
	public let id: Int
	public var picture: String?
	public let firstName: String
	public let lastName: String
	public let email: String
	public let phoneNumber: String
	
	public var UIPicture: UIImage? {
		if picture != nil {
			return UserPictureHelper.DecodeImage(base64String: self.picture!)
		}
		
		return nil
	}
}

public extension User {
	
	var fullName: String {
		return "\(self.firstName) \(self.lastName)"
	}
	
	var fullNameReverse: String {
		return "\(self.lastName), \(self.firstName)"
	}
}
