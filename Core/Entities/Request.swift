//
//  Request.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

public struct Request {
    public let url: String
    public let method: HttpMethod
    public let parameters: [String: Any]?
    public let headers: [String: String]?
    
    public init(url: String, method: HttpMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
