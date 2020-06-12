//
//  LoginViewPresenter.swift
//  RxCode
//
//  Created by Olarn Ungumnuayporn on 8/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewPresenter {
	
	var loginApi: LoginApi
	
	let inputLogin = BehaviorSubject<String>(value: "")
	let inputPassword = BehaviorSubject<String>(value: "")
	let outputUIValidator: Observable<Bool>!
	
	init(api: LoginApi) {
		
		self.loginApi = api
		
		let loginValidation = inputLogin.map { value -> Bool in
			return value.count >= 4
		}
		
		let passwordValidation = inputPassword.map { value -> Bool in
			return value.count >= 4
		}
		
		outputUIValidator = Observable
			.combineLatest(
				loginValidation.asObservable(),
				passwordValidation.asObservable())
			.map { a, b -> Bool in
				return a && b
		}
	}
	
	func validate(_ userName: String, and password: String) -> Observable<Bool> {
		return self.loginApi.validate(
			userName: userName,
			password: password
		)
	}
}
