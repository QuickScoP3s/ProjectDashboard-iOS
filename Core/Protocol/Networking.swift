//
//  Networking.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Alamofire

public protocol Networking {
	
	func getJSONResult<R: Codable>(from request: Request, completion: @escaping((Result<R, Error>) -> Void))
	
	func executeWithoutResult(request: Request, completion: @escaping ((Result<Void, Error>) -> Void))
	
	func execute(request: Request, completion: @escaping ((Result<Response?, Error>) -> Void))
}
