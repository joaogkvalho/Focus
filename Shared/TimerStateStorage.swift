//
//  TimerStateStorage.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 07/09/26.
//

import Foundation

final class TimerStateStorage {
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let endDate = "timer.endDate"
        static let remainingTime = "timer.remainingTime"
        static let mode = "timer.mode"
        static let completedPomodoros = "timer.completedPomodoros"
        static let isPaused = "timer.isPaused"
    }

    func saveRunningTimer(
        endDate: Date,
        mode: TimerMode,
        completedPomodoros: Int
    ) {
        defaults.set(endDate, forKey: Keys.endDate)
        defaults.set(mode.rawValue, forKey: Keys.mode)
        defaults.set(completedPomodoros, forKey: Keys.completedPomodoros)
        defaults.set(false, forKey: Keys.isPaused)

        defaults.removeObject(forKey: Keys.remainingTime)
    }

    func savePausedTimer(
        remainingTime: TimeInterval,
        mode: TimerMode,
        completedPomodoros: Int
    ) {
        defaults.set(remainingTime, forKey: Keys.remainingTime)
        defaults.set(mode.rawValue, forKey: Keys.mode)
        defaults.set(completedPomodoros, forKey: Keys.completedPomodoros)
        defaults.set(true, forKey: Keys.isPaused)

        defaults.removeObject(forKey: Keys.endDate)
    }

    func load() -> (
        endDate: Date?,
        remainingTime: TimeInterval?,
        mode: TimerMode,
        completedPomodoros: Int,
        isPaused: Bool
    )? {

        guard
            let modeRawValue = defaults.string(
                forKey: Keys.mode
            ),
            let mode = TimerMode(
                rawValue: modeRawValue
            )
        else {
            return nil
        }

        let endDate = defaults.object(
            forKey: Keys.endDate
        ) as? Date

        let remainingTime: TimeInterval?

        if defaults.object(forKey: Keys.remainingTime) != nil {
            remainingTime = defaults.double(
                forKey: Keys.remainingTime
            )
        } else {
            remainingTime = nil
        }

        let completedPomodoros = defaults.integer(
            forKey: Keys.completedPomodoros
        )

        let isPaused = defaults.bool(
            forKey: Keys.isPaused
        )

        return (
            endDate,
            remainingTime,
            mode,
            completedPomodoros,
            isPaused
        )
    }

    func clear() {
        defaults.removeObject(forKey: Keys.endDate)
        defaults.removeObject(forKey: Keys.remainingTime)
        defaults.removeObject(forKey: Keys.mode)
        defaults.removeObject(forKey: Keys.completedPomodoros)
        defaults.removeObject(forKey: Keys.isPaused)
    }
}
