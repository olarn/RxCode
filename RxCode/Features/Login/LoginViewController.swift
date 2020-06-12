//
//  ViewController.swift
//  RxCode
//
//  Created by Olarn Ungumnuayporn on 8/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
	
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var buttonLogin: UIButton!
	
	var presenter: LoginViewPresenter!
	
	let bag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter = LoginViewPresenter(api: LoginApi(apiClient: ApiClient()))
		
		bindingUI(to: presenter)
		handleValidation(from: presenter)
	}
	
	@IBAction func buttonTapped(_ sender: Any) {
		let username = self.loginTextField.text ?? ""
		let password = self.passwordTextField.text ?? ""
		presenter
			.validate(username, and: password)
			.subscribe(onNext: { [weak self] result in
				self?.showAlert(success: result)
			}).disposed(by: bag)
	}
}

// MARK: - bindingUItoRx

extension LoginViewController {
	
	private func bindingUI(to presenter: LoginViewPresenter) {
		loginTextField
			.rx
			.text
			.orEmpty
			.bind(to: presenter.inputLogin)
			.disposed(by: bag)
		
		passwordTextField
			.rx
			.text
			.orEmpty
			.bind(to: presenter.inputPassword)
			.disposed(by: bag)
	}
	
	private func handleValidation(from presenter: LoginViewPresenter) {
		presenter
			.outputUIValidator
			.subscribe(onNext: { [weak self] result in
				if let self = self {
					self.setButtonState(to: result)
				}})
			.disposed(by: bag)
	}
}

// MARK: - Set Button State

extension LoginViewController {
	
	private func setButtonState(to state: Bool) {
		self.buttonLogin.isEnabled = state
		self.buttonLogin.backgroundColor = state ? .blue : .gray
	}
	
	private func showAlert(success: Bool) {
		let resultMessage = success ? "Hello user" : "Invalid username and/or password"
		let alert = UIAlertController(title: "Info.", message: resultMessage, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
