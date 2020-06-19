//
//  ApiClient.swift
//  RxCode
//
//  Created by Olarn Ungumnuayporn on 10/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

enum ApiClientError: Error {
	case invalidBodyMethodConsistency
}

class ApiClient: ApiClientProtocol {

	let bag = DisposeBag()

	func request(_ request: ApiRequest) throws -> Observable<Data> {

		if (request.method == .post || request.method == .put) &&
		   (request.body == nil) {
			throw ApiClientError.invalidBodyMethodConsistency
		}

		var alamoRequest = URLRequest(url: URL(string: request.url)!)
		alamoRequest.httpMethod = request.method.rawValue
		alamoRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.header?.forEach { key, value in
			alamoRequest.setValue(value, forHTTPHeaderField: key)
		}
		if request.body != nil {
			alamoRequest.httpBody = request.body
		}

		return RxAlamofire
			.request(alamoRequest as URLRequestConvertible)
			.responseData()
			.map { _, data -> Data in
				return data
		}
	}
}
