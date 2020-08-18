//
//  BaseService.swift
//  Networking
//
//  Created by Waut Wyffels on 16/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core

public class BaseService {
	
	let baseUrl: String
	let networking: Networking
	
	init(baseUrl: String, networking: Networking) {
		self.baseUrl = baseUrl
		self.networking = networking
	}
}
