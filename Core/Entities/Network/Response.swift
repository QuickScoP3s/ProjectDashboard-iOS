//
//  Response.swift
//  Core
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import Alamofire

public struct Response {
    public let request: Request
    public let data: Data?
    
    // Alamofire Response: Only needed for NativeNetworking
    public let AFResponse: AFDataResponse<Data>?
    
    public init(request: Request, data: Data? = nil, response: AFDataResponse<Data>? = nil) {
        self.request = request
        self.data = data
        self.AFResponse = response
    }
    
    public init(fromAFResponse response: AFDataResponse<Data>, request: Request) {
        self.request = request
        self.data = response.data
        self.AFResponse = response
    }
    
    public var statusCode: Int? {
        return AFResponse?.response?.statusCode
    }
}
