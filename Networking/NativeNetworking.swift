//
//  NativeNetworking.swift
//  Networking
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import Core

public class NativeNetworking: Networking {
    
    private let baseUrl = "https://projectdashboard.azurewebsites.net/api/"
    
    public init() {}
    
    public func execute(request: Request, completionHandler: @escaping ((Result<Data?, Error>) -> Void)) {
        guard let url = URL(string: baseUrl + request.url) else {
            return
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(Result.failure(error))
                return
            }
            
            completionHandler(Result.success(data))
        }
        
        task.resume()
    }
}
