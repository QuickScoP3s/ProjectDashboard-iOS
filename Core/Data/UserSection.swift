//
//  UserSection.swift
//  Core
//
//  Created by Waut Wyffels on 30/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public struct UserSection {
	
	public let beginLetter: Character
	public var users: [User]
	
	public init(beginLetter: Character, users: [User]) {
		self.beginLetter = beginLetter
		self.users = users
		
		self.sortUsers()
	}
	
	public mutating func sortUsers() {
		self.users.sort { (lp: User, rp: User) -> Bool in lp.fullNameReverse > rp.fullNameReverse }
	}
	
	public static func group(users: [User]) -> [UserSection] {
		let groups = Dictionary(grouping: users) { $0.fullNameReverse.first! }
		return groups.map(UserSection.init(beginLetter:users:))
	}
}
