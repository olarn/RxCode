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

class LoginViewController: MyWealthViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var changeLanguageButton: UIButton!
    
    var presenter: LoginViewPresenter!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		presenter = LoginViewPresenter(api: LoginApi(apiClient: ApiClient()))
		
        bindingUI(to: presenter)
        handleValidation(from: presenter)
		handleOnLocaleChange()
    }
	
    @IBAction func buttonChangeLangTapped(_ sender: Any) {
        self.toggleLanguage()
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
				self?.setButtonState(to: result)
			})
            .disposed(by: bag)
    }
	
	private func handleOnLocaleChange() {
		self.onLocaleChanged
			.subscribe(onNext: { [weak self] _ in
				self?.changeLanguageButton.setTitle("en".localized(), for: .normal)
				self?.buttonLogin.setTitle("Login".localized(), for: .normal)
			})
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
        let resultMessage = success ?
            "Hello".localized() + " " + (self.loginTextField.text ?? "") :
            "Invalid username and/or password".localized()
        
        let alert = UIAlertController(title: "Info.".localized(), message: resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }    
}
