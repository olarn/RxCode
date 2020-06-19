//
//  LoginApi.swift
//  RxCode
//
//  Created by Olarn Ungumnuayporn on 9/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import Foundation
import RxSwift


class LoginApi {
	
	var apiClient: ApiClientProtocol
	
	init(apiClient: ApiClientProtocol) {
		self.apiClient = apiClient
	}
	
	func validate(_ userName: String, and password: String) -> Observable<Bool> {

		let request = ApiRequest(
			url: "https://extendsclass.com/api/json-storage/bin/ffddddb",
			method: .get
		)
		
		return try! self.apiClient
			.request(request)
			.map { data -> Bool in
				let decoder = JSONDecoder()
				do {
					let user = try decoder.decode(User.self, from: data)
					return user.userName == userName
				} catch {
					return false
				}
		}
	}
}
