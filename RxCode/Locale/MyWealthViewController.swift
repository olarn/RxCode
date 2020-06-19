//
//  MyWealthViewController.swift
//  RxCode
//
//  Created by Olarn U. on 15/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import UIKit
import Localize_Swift
import RxSwift

///
/// UIViewController super class for all MyWealth app
/// to handle language toggle.
///
/// you can override func - applyLocaleChangeToUI() - to cahnge language,
/// or use RxSwift to subscribe onChanged to acccept notify when locale changed.
class MyWealthViewController: UIViewController {

	var onLocaleChanged = BehaviorSubject<String>(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        applyCurrentLanguage()
        self.applyLocaleChangeToUI()
    }

// MARK: - notification center lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyLocaleChangeToUI),
            name: NSNotification.Name(LCLLanguageChangeNotification),
            object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

// MARK: - Change Locale

    func toggleLanguage() {
        let localStore = LocalStore()
        let newLang = localStore.lang == "en" ? "th" : "en"
        Localize.setCurrentLanguage(newLang)
        localStore.lang = newLang
    }

    private func applyCurrentLanguage() {
        let localStore = LocalStore()
        Localize.setCurrentLanguage(localStore.lang)
    }

// MARK: - emit localed changed to subclass

    @objc private func applyLocaleChangeToUI() {
		onLocaleChanged.onNext(Localize.currentLanguage())
	}
}
