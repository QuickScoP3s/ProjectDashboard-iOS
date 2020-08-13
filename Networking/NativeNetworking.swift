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
import Utils

public class NativeNetworking: Networking {
	
	private let baseUrl: URL
	private let userHelper: UserHelper
	
	private let jsonDecoder: JSONDecoder
	
	public convenience init(userHelper: UserHelper) {
		self.init(baseUrl: "https://projectdashboard.azurewebsites.net/api/", userHelper: userHelper)
	}
	
	public init(baseUrl: String, userHelper: UserHelper, jsonDecoder: JSONDecoder = JSONDecoder()) {
		self.baseUrl = URL(string: baseUrl)!
		self.userHelper = userHelper
		
		self.jsonDecoder = jsonDecoder
		self.jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
	}
	
	
	public func getJSONResult<R: Codable>(from request: Core.Request, completion: @escaping ((Result<R, Error>) -> Void)) {
		self.execute(request: request) { result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					completion(Result.failure(error))
				
				case .success(let response):
					do {
						let response = try self.jsonDecoder.decode(R.self, from: response!.data!)
						completion(Result.success(response))
					}
					catch let error {
						completion(Result.failure(error))
					}
			}
		}
	}
	
	public func executeWithoutResult(request: Core.Request, completion: @escaping ((Result<Void, Error>) -> Void)) {
		self.execute(request: request) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success:
					completion(Result.success(()))
			}
		}
	}
	
	public func execute(request: Core.Request, completion: @escaping ((Result<Response?, Error>) -> Void)) {
		// Preparation
		let baseUrl = self.baseUrl.absoluteString
		let url = baseUrl + request.parameterisedUrl
		
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
		var urlRequest = URLRequest(url: URL(string: url)!)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.httpBody = request.body?.toJSONData()
		
		headers.forEach {
			urlRequest.addValue($0.value, forHTTPHeaderField: $0.name)
		}
		
		// Execute
		AF.request(urlRequest)
			.validate()
			.responseData { response in
				self.complete(fromResponse: response, withRequest: request, completion: completion)
		}
	}
	
	private func complete(fromResponse response: AFDataResponse<Data>, withRequest request: Core.Request, completion: (Result<Response?, Error>) -> Void) {
		switch response.result {
			case .success:
				completion(Result.success(Response(fromAFResponse: response, request: request)))
			case .failure(let error):
				completion(Result.failure(error))
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
