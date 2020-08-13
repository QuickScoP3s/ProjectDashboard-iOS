//
//  Request.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import Alamofire

public struct Request {
	public let url: String
	public let method: HTTPMethod
	public let parameters: [String: Any]?
	public let headers: HTTPHeaders?
	
	public let body: Encodable?
	
	public init(url: String, method: HTTPMethod = .get, body: Encodable? = nil, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil) {
		self.url = url
		self.method = method
		self.parameters = parameters
		self.headers = headers
		self.body = body
	}
	
	/// Creates an uri-encoded string (e.g. example.com/path?param1=val1&param2=val2)
	public var parameterisedUrl: String {
		guard let params = parameters?.map({ "\($0.key)=\($0.value)" }).joined(separator: "&") else {
			return url
		}
		
		return "\(url)?\(params)"
	}
}
