//
//  RxCodeUITests.swift
//  RxCodeUITests
//
//  Created by Olarn Ungumnuayporn on 18/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import XCTest

class RxCodeUITests: XCTestCase {
	
	var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
		app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {

	}

	/// ```
	/// UI Test Example with type text
    func testLoginSuccess() throws {
		registerDismissAlert()

		let logintextTextField = app.textFields["loginText"]
		logintextTextField.tap()
		logintextTextField.typeText("1234")
		
		let passwordTextField = app.textFields["passwordText"]
		passwordTextField.tap()
		passwordTextField.typeText("1234")
		
		app.buttons["loginButton"].tap()
    }
	
	/// ```
	/// UI Test Example with keyboard tap
	func testLoginFail() throws {
		registerDismissAlert()

		app.textFields["loginText"].tap()
		
		let moreKey = app.keys["more"]

		moreKey.tap()
		let key = app.keys["1"]
		for _ in 1...4 {
			key.tap()
		}

		app.textFields["passwordText"].tap()
		moreKey.tap()
		for _ in 1...4 {
			key.tap()
		}

		app.buttons["loginButton"].tap()
	}
}

extension XCTestCase {
	/// ```
	/// Handle while alert occur.
	func registerDismissAlert() {
		addUIInterruptionMonitor(withDescription: "Info.") { alert -> Bool in
			let okButton = alert.buttons["OK"]
			if okButton.exists {
				okButton.tap()
				return true
			}

			let okThaiButton = alert.buttons["รับทราบ"]
			if okThaiButton.exists {
				okThaiButton.tap()
				return true
			}
			return false
		}
	}
}
