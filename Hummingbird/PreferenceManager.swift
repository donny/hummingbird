//
//  PreferenceManager.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

private let trelloTokenKey = "trelloToken"

class PreferenceManager {
    private let userDefaults = UserDefaults.standard
    
    var trelloToken: String? {
        get {
            return userDefaults.object(forKey: trelloTokenKey) as? String
        }
        set {
            userDefaults.set(newValue, forKey: trelloTokenKey)
        }
    }
    
    init() {
        registerDefaultPreferences()
    }
    
    func registerDefaultPreferences() {
        let defaults = [trelloTokenKey: ""]
        userDefaults.register(defaults: defaults)
    }
}
