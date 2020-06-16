//
//  MyWealthViewController.swift
//  RxCode
//
//  Created by Olarn U. on 15/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import UIKit
import Localize_Swift

///
/// UIViewController super class for all MyWealth app
/// to handle language toggle.
///
/// "setText()" method need to be override in syb-class.
class MyWealthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCurrentLanguage()
        self.setText()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setText),
            name: NSNotification.Name(LCLLanguageChangeNotification),
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func toggleLanguage() {
        let localStore = LocalStore()
        let newLang = localStore.lang == "en" ? "th" : "en"
        Localize.setCurrentLanguage(newLang)
        localStore.lang = newLang
    }
    
    func applyCurrentLanguage() {
        let localStore = LocalStore()
        Localize.setCurrentLanguage(localStore.lang)
    }
    
    @objc func setText() {
        assert(false, "Please override this method in MyWealthViewController sub-class to handle language changed.")
    }
}


