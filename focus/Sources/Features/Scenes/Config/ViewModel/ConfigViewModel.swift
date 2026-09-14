//
//  ConfigViewModel.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 02/09/26.
//

import Foundation

final class ConfigViewModel {

    private let config = UserDefaultsManager()

    var settings: ConfigModel {
        config.loadConfig()
    }

    func saveConfig(
        focusDuration: TimeInterval,
        shortBreakDuration: TimeInterval,
        longBreakDuration: TimeInterval
    ) {

        let settings = ConfigModel(
            focusDuration: focusDuration,
            shortBreakDuration: shortBreakDuration,
            longBreakDuration: longBreakDuration
        )

        config.saveConfig(settings)
    }

    func loadConfig() -> ConfigModel {
        config.loadConfig()
    }
}
