//
//  TimerState.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation

struct TimerState {
    let mode: TimerMode
    let duration: TimeInterval
    var remainingTime: TimeInterval
    var endDate: Date?
    var isRunning: Bool
    var completedPomodoros: Int
}
