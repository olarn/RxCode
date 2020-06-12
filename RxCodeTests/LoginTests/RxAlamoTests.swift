//
//  RxAlamoTest.swift
//  RxCodeTests
//
//  Created by Olarn Ungumnuayporn on 11/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift
import RxAlamofire
import RxBlocking
@testable import RxCode

struct Account: Codable {
	var idType: String
	var idValue: String
}

class RxAlamoTests: XCTestCase {
	
	let bag = DisposeBag()
	
	func testCallPostApi() throws {
		
		let body = try! JSONEncoder().encode(Account(
			idType: "I",
			idValue: "3100202497392"
		))
		
		let apiRequest = ApiRequest(
			url: "https://api.c1-alpha-tiscogroup.com/public/wmb-port-v1-service/wmb-port/accounts/inquiry",
			method: .post,
			header: nil,
			body: body)
		
		let response = try! ApiClient()
			.request(apiRequest)
			
		let result = try! response
			.toBlocking()
			.first()
		
		XCTAssert(result != nil)
	}
	
	func testCallWithInvalidApiRequestExpectThrowException() throws {
		let request = ApiRequest(
			url: "",
			method: .post,
			header: nil,
			body: nil)
		do {
			try _ = ApiClient().request(request)
		} catch {
			XCTAssertTrue(true)
		}
	}
	
}
