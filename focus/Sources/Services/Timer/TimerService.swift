//
//  TimerService.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation

final class TimerService: TimerServiceProtocol {
    var onTick: ((TimeInterval) -> Void)?
    var onFinish: (() -> Void)?
    
    private var timer: Timer?
    private var endDate: Date?
    private var remainingTime: TimeInterval = 0
    
    func start(duration: TimeInterval) {
        endDate = Date().addingTimeInterval(duration)
        
        startTimer()
    }
    
    func pause() -> TimeInterval {
        timer?.invalidate()
        timer = nil
        
        guard let endDate else {
            return remainingTime
        }
        
        remainingTime = max(
            endDate.timeIntervalSinceNow,
            0
        )
        
        return remainingTime
    }
    
    func resume() {
        endDate = Date().addingTimeInterval(remainingTime)
        
        startTimer()
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        
        endDate = nil
        remainingTime = 0
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true,
        ) { [weak self] _ in
            self?.tick()
        }
    }
    
    private func tick() {
        guard let endDate else {
            return
        }
        
        remainingTime = max(
            endDate.timeIntervalSinceNow,
            0
        )
        
        onTick?(remainingTime)
        
        if remainingTime <= 0 {
            finish()
        }
    }
    
    private func finish() {
        timer?.invalidate()
        timer = nil
        
        onFinish?()
    }
}
