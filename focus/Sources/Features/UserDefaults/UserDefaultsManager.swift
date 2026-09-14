//
//  UserDefaultsManager.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 02/09/26.
//

import Foundation

final class UserDefaultsManager {
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let focusDuration = "focusDuration"
        static let shortBreakDuration = "shortBreakDuration"
        static let longBreakDuration = "longBreakDuration"
    }
    
    private enum Defaults {
        static let focusDuration: Double = 25 * 60
        static let shortBreakDuration: Double = 5 * 60
        static let longBreakDuration: Double = 15 * 60
    }
    
    func saveConfig(_ settings: ConfigModel) {
        defaults.set(settings.focusDuration, forKey: Keys.focusDuration)
        defaults.set(settings.shortBreakDuration, forKey: Keys.shortBreakDuration)
        defaults.set(settings.longBreakDuration, forKey: Keys.longBreakDuration)
    }
    
    func loadConfig() -> ConfigModel {
        ConfigModel(
            focusDuration: defaults.double(forKey: Keys.focusDuration) as? TimeInterval
                ?? Defaults.focusDuration,
            shortBreakDuration: defaults.double(forKey: Keys.shortBreakDuration) as? TimeInterval
                ?? Defaults.shortBreakDuration,
            longBreakDuration: defaults.double(forKey: Keys.longBreakDuration) as? TimeInterval
                ?? Defaults.longBreakDuration
        )
    }
}
