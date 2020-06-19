//
//  LoginValidationTests.swift
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

class LoginValidationTests: XCTestCase {

	func testValidateLoginToApi_user_1234_pass_1234_should_success() throws {
		let fakeClient = FakeApiClient()
		let loginApi = LoginApi(apiClient: fakeClient)
		let loginPresenter = LoginViewPresenter(api: loginApi)

		do {
			guard let loginResult = try loginPresenter
				.validate("1234", and: "1234")
				.toBlocking()
				.first() else {
					XCTFail(#function)
					return
			}
			XCTAssertTrue(loginResult, "Got \(loginResult), Want \(true)")
		} catch {
			XCTFail(#function)
		}
	}

	func testValidateLoginToApi_user_1111_pass_1111_should_fail() throws {
		let fakeClient = FakeApiClient()
		let loginApi = LoginApi(apiClient: fakeClient)
		let loginPresenter = LoginViewPresenter(api: loginApi)

		do {
			guard let loginResult = try loginPresenter
				.validate("1111", and: "1111")
				.toBlocking()
				.first() else {
					XCTFail(#function)
					return
			}
			XCTAssertFalse(loginResult, "Got \(loginResult), Want \(false)")
		} catch {
			XCTFail(#function)
		}
	}

	func testValidateLoginToApi_with_invalid_json_format_should_fail() throws {

		let invalidJsonDoc = "a;foguhae;ogh"

		let fakeClient = FakeApiClient()
		fakeClient.jsonResponseString = invalidJsonDoc

		let loginApi = LoginApi(apiClient: fakeClient)
		let loginPresenter = LoginViewPresenter(api: loginApi)
		do {
			guard let loginResult = try loginPresenter
				.validate("1111", and: "1111")
				.toBlocking()
				.first() else {
					XCTFail(#function)
					return
			}
			XCTAssertFalse(loginResult, "Got \(loginResult), Want \(false)")
		} catch {
			XCTFail(#function)
		}
	}
}
