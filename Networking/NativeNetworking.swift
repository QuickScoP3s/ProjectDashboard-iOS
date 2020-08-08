//
//  NativeNetworking.swift
//  Networking
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import Core
import Alamofire

public class NativeNetworking: Networking {
    private let baseUrl: URL
    private let userHelper: UserHelper
    
    public convenience init(userHelper: UserHelper) {
        self.init(baseUrl: "https://projectdashboard.azurewebsites.net/api/", userHelper: userHelper)
    }
    
    public init(baseUrl: String, userHelper: UserHelper) {
        self.baseUrl = URL(string: baseUrl)!
        self.userHelper = userHelper
    }
    
    public func execute(request: Core.Request, completionHandler: @escaping ((Result<Response?, Error>) -> Void)) {
        // Preparation
        let url = baseUrl.appendingPathComponent(request.url)
        
        var headers: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json")
        ]
        
        if userHelper.isSignedIn {
            headers.add(name: "Authorization", value: "Bearer \(userHelper.authToken!)")
        }
        
        request.headers?.forEach {
            headers.add($0)
        }
        
        // Create URL Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.toJSONData()
        
        headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.name)
        }
        
        // Execute
        AF.request(urlRequest)
            .validate()
            .responseData { response in
                self.complete(fromResponse: response, withRequest: request, completionHandler: completionHandler)
        }
    }
    
    private func complete(fromResponse response: AFDataResponse<Data>, withRequest request: Core.Request, completionHandler: (Result<Response?, Error>) -> Void) {
        switch response.result {
        case .success:
            completionHandler(Result.success(Response(fromAFResponse: response, request: request)))
        case .failure(let error):
            completionHandler(Result.failure(error))
        }
    }
}

// MARK: - Extensions

// Private to not pollute Apple-provided protocols
private extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
