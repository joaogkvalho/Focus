//
//  TimerViewModel.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation

final class TimerViewModel {
    private var timerService: TimerServiceProtocol
    private var notificationService: NotificationsService
    private var settings: ConfigViewModel
    
    private let timerStateStorage = TimerStateStorage()

    private(set) var mode: TimerMode = .work
    private(set) var duration: TimeInterval
    private(set) var remainingTime: TimeInterval
    private(set) var completedPomodoros = 0

    var onTimeUpdate: ((String) -> Void)?
    var onStateChange: (() -> Void)?
    var onTimerFinished: (() -> Void)?
    var onTick: ((TimeInterval) -> Void)?

    init(
        timerService: TimerService,
        notificationService: NotificationsService,
        settings: ConfigViewModel
    ) {
        self.timerService = timerService
        self.notificationService = notificationService
        self.settings = settings

        let settings = settings.loadConfig()

        self.duration = settings.focusDuration
        self.remainingTime = settings.focusDuration

        bindTimer()
    }

    private func formattedTime(_ time: TimeInterval) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60

        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }

    private func duration(for mode: TimerMode) -> TimeInterval {
        switch mode {

        case .work:
            return settings.settings.focusDuration

        case .shortBreak:
            return settings.settings.shortBreakDuration

        case .longBreak:
            return settings.settings.longBreakDuration
        }
    }

    func loadSettings() {
        guard timerStateStorage.load() == nil else {
            return
        }

        duration = duration(for: mode)
        remainingTime = duration

        onTimeUpdate?(formattedTime(remainingTime))
        onStateChange?()
    }

    private func changeMode(to mode: TimerMode) {
        self.mode = mode
        self.duration = duration(for: mode)
        self.remainingTime = duration
    }

    private func handleTimerFinished() {
        switch mode {

        case .work:
            completedPomodoros += 1

            if completedPomodoros % 4 == 0 {
                changeMode(to: .longBreak)
            } else {
                changeMode(to: .shortBreak)
            }

        case .shortBreak:
            changeMode(to: .work)

        case .longBreak:
            completedPomodoros = 0
            changeMode(to: .work)
        }

        onTimeUpdate?(formattedTime(remainingTime))
        onTick?(remainingTime)
    }

    func requestNotificationPermission() {
        notificationService.requestPermission()
    }

    private func scheduleTimerNotification() {
        let notification = notificationContent(for: mode)

        notificationService.scheduleNotification(
            title: notification.title,
            body: notification.body,
            after: remainingTime
        )
    }

    private func notificationContent(
        for mode: TimerMode
    ) -> (title: String, body: String) {

        switch mode {

        case .work:
            return (
                title: "Tempo de foco acabou 🍅",
                body: "Seu tempo de foco acabou. Inicie sua pausa e descanse por um tempo."
            )

        case .shortBreak:
            return (
                title: "Pausa acabou ☀️",
                body: "Sua pausa terminou. É hora de voltar ao foco."
            )

        case .longBreak:
            return (
                title: "Pausa longa acabou 🎯",
                body: "Sua pausa longa terminou. Prepare-se para começar um novo ciclo de foco."
            )
        }
    }

    func refreshUI() {
        onTimeUpdate?(formattedTime(remainingTime))
        onTick?(remainingTime)
        onStateChange?()
    }
}

private extension TimerViewModel {
    func bindTimer() {
        timerService.onTick = { [weak self] remaining in
            guard let self else {
                return
            }

            self.remainingTime = remaining

            self.onTimeUpdate?(
                self.formattedTime(remaining)
            )

            self.onTick?(remaining)
        }

        timerService.onFinish = { [weak self] in
            guard let self else {
                return
            }

            self.timerStateStorage.clear()

            self.handleTimerFinished()

            self.onStateChange?()
            self.onTimerFinished?()
        }
    }
}

extension TimerViewModel {
    func start() {
        let endDate = Date().addingTimeInterval(
            remainingTime
        )

        timerStateStorage.saveRunningTimer(
            endDate: endDate,
            mode: mode,
            completedPomodoros: completedPomodoros
        )

        timerService.start(
            duration: remainingTime
        )

        scheduleTimerNotification()

        onStateChange?()
    }

    func pause() {
        remainingTime = timerService.pause()

        timerStateStorage.savePausedTimer(
            remainingTime: remainingTime,
            mode: mode,
            completedPomodoros: completedPomodoros
        )

        notificationService.cancelTimerNotification()

        onTimeUpdate?(
            formattedTime(remainingTime)
        )

        onStateChange?()
    }

    func reset() {
        timerService.reset()

        timerStateStorage.clear()

        notificationService.cancelTimerNotification()

        remainingTime = duration

        onTimeUpdate?(
            formattedTime(remainingTime)
        )

        onStateChange?()
    }
    
    func restoreTimerState() {
        guard let state = timerStateStorage.load() else {
            return
        }

        mode = state.mode
        duration = duration(for: mode)
        completedPomodoros = state.completedPomodoros

        if state.isPaused {
            remainingTime = state.remainingTime ?? duration

            refreshUI()

            return
        }

        guard let endDate = state.endDate else {
            timerStateStorage.clear()
            return
        }

        let remaining = endDate.timeIntervalSinceNow

        if remaining > 0 {
            remainingTime = remaining

            timerService.start(
                duration: remainingTime
            )

            scheduleTimerNotification()
        } else {
            timerService.reset()

            timerStateStorage.clear()
            notificationService.cancelTimerNotification()

            handleTimerFinished()

            onTimerFinished?()
        }

        refreshUI()
    }
}
