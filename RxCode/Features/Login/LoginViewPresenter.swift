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

	let bag = DisposeBag()
	var loginApi: LoginApi

	let inputLogin = BehaviorSubject<String>(value: "")
	let inputPassword = BehaviorSubject<String>(value: "")
	let outputCanDoLogin: Observable<Bool>!

	private let validatingStatus = BehaviorSubject<Bool>(value: false)
	var outputIsValidating: Observable<Bool> {
		return validatingStatus.asObserver()
	}

	init(api: LoginApi) {
		self.loginApi = api

		let loginValidation = inputLogin.map { value -> Bool in
			return value.count >= 4
		}

		let passwordValidation = inputPassword.map { value -> Bool in
			return value.count >= 4
		}

		outputCanDoLogin = Observable
			.combineLatest(
				loginValidation.asObservable(),
				passwordValidation.asObservable())
			.map { loginIsValid, passwordIsValid -> Bool in
				return loginIsValid && passwordIsValid
		}
	}

	func validate(_ userName: String, and password: String) -> Observable<Bool> {
		validatingStatus.onNext(true)

		return Observable.create { observer -> Disposable in
			self.loginApi
				.validate(userName, and: password)
				.subscribe(onNext: { [weak self] result in
					self?.validatingStatus.onNext(false)
					observer.onNext(result)
					observer.onCompleted()
				})
				.disposed(by: self.bag)
			return Disposables.create()
		}

	}
}
