//
//  LoginValidatingStatusTests.swift
//  RxCodeTests
//
//  Created by Olarn Ungumnuayporn on 19/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxCode

class LoginValidatingStatusTests: XCTestCase {

	let bag = DisposeBag()

    func testIsValidatingDefaultStateShouldReturnTrue() throws {
		let loginPresenter = LoginViewPresenter(api: LoginApi(apiClient: FakeApiClient()))
		do {
			guard let defaultState = try loginPresenter.outputIsValidating.asObservable().toBlocking().first() else {
				XCTFail(#function)
				return
			}
			XCTAssertFalse(defaultState)
		} catch {
			XCTFail(#function)
		}
	}

    func testIsValidatingWhenPerformLogin_ItShouldBeFalseThenTrue() throws {

		// Arrange
		let exp = expectation(description: "")
		let expectedStates = [false, true, false] // default = false, true when perform, false when finish
		var actualResultsStates = [Bool]()
		let loginPresenter = LoginViewPresenter(api: LoginApi(apiClient: FakeApiClient()))

		// Act
		loginPresenter.outputIsValidating.subscribe(onNext: { result in
			actualResultsStates.append(result)
		}).disposed(by: bag)

		// Assert
		loginPresenter.validate("", and: "")
			.subscribe(onNext: { _ in
				XCTAssertEqual(expectedStates, actualResultsStates)
				exp.fulfill()
			}).disposed(by: bag)

		// Blocking
		waitForExpectations(timeout: 0.5) { error in
			if let err = error {
				XCTFail(err.localizedDescription)
			}
		}
	}
}
