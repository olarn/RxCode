//
//  FakeClientApiForLoginTests.swift
//  RxCodeTests
//
//  Created by Olarn Ungumnuayporn on 10/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxCode

// Note: use https://extendsclass.com/json-storage.html
// to store example API
//

class FakeApiClient: ApiClientProtocol {
	
	var jsonResponseString =
	"""
		{
		  "userName" : "1234",
		  "firstName" : "John",
		  "lastName" : "Wick"
		}
	"""

	func request(_ request: ApiRequest) throws -> Observable<Data> {
		let data = jsonResponseString.data(using: .utf8)!
		return Observable.just(data)
	}
}
