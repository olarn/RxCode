//
//  LocalStore.swift
//  RxCode
//
//  Created by Olarn U. on 16/6/2563 BE.
//  Copyright © 2563 Olarn Ungumnuayporn. All rights reserved.
//

import Foundation
import Localize_Swift

protocol LocalStoreLangProtocol {
    var lang: String { get set }
}

class LocalStore {
    
    enum Keys: String {
        case lang = "RxLang"
    }
    
    var lang: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.lang.rawValue) ?? "en"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.lang.rawValue)
        }
    }
}
