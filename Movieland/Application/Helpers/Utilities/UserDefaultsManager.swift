//
//  UserDefaultsManager.swift
//  Movieland
//
//  Created by Dante Solorio on 05/05/21.
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Private properties
    
    private static let defaults = UserDefaults.standard
    
    // MARK: - Keys
    
    private struct Keys {
        static let filterSelected = "FilterSelected"
    }
    
    // MARK: - Properties
    
    static var filterSelected: Int {
        get {
            return defaults.integer(forKey: Keys.filterSelected)
        }
        set (value) {
            defaults.set(value, forKey: Keys.filterSelected)
            defaults.synchronize()
        }
    }
}
