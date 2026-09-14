//
//  ConfigModel.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 02/09/26.
//

import Foundation

struct ConfigModel {
    var focusDuration: TimeInterval
    var shortBreakDuration: TimeInterval
    var longBreakDuration: TimeInterval
}

let settings = ConfigModel(
    focusDuration: 25 * 60,
    shortBreakDuration: 5 * 60,
    longBreakDuration: 15 * 60
)
