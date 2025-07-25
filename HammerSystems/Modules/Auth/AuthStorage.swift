//
//  AuthStorage.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



enum AuthStorage {
    private static let isLoggedKey = "IsUserLogged"
    
    static var isLoggedIn: Bool {
        get {UserDefaults.standard.bool(forKey: isLoggedKey) }
        set {UserDefaults.standard.setValue(newValue, forKey: isLoggedKey)}
    }
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: isLoggedKey)
    }
}
