//
//  RxCodeTests.swift
//  RxCodeTests
//
//  Created by Olarn Ungumnuayporn on 8/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxCode

class RxCodeLoginTests: XCTestCase {
	
	let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
	let bag = DisposeBag()
	var presenter: LoginViewPresenter!
	
	override func setUp() {
		presenter = LoginViewPresenter(api: LoginApi(apiClient: FakeApiClient()))
	}
	
	func testLoginUIWith_user_1234_should_success() throws {
		presenter.inputLogin.onNext("user")
		presenter.inputPassword.onNext("1234")
		
		let expectedResult = try! presenter
			.outputUIValidator
			.asObservable()
			.toBlocking()
			.first()!
		
		XCTAssertTrue(expectedResult)
	}

	func testLoginUIWith_user_1_pass_1_should_fail() throws {
		presenter.inputLogin.onNext("1")
		presenter.inputPassword.onNext("1")
		
		let expectedResult = try! presenter
			.outputUIValidator
			.asObservable()
			.toBlocking()
			.first()!
		
		XCTAssertFalse(expectedResult)
	}

}
