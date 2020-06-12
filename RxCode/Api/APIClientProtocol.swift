//
//  APIClient.swift
//  RxCode
//
//  Created by Olarn Ungumnuayporn on 9/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import Foundation
import RxSwift

enum ApiMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

struct ApiRequest {
	var url: String
	var method: ApiMethod
	var header: [String: String]?
	var body: Data?
}

struct ApiResponse {
	var meta: Data?
	var data: Data
}

enum ApiClientException: Error {
	case invalidPostRequest
}

/// ```
/// This protocol intend to wrapped API client library
/// like Alamofire or Moya tomake change cheap
/// in the future if needed.
protocol ApiClientProtocol {
	func request(_ request: ApiRequest) throws -> Observable<Data>
}
