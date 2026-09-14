//
//  TimerServiceProtocol.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation

protocol TimerServiceProtocol {
    var onTick: ((TimeInterval) -> Void)? { get set }
    var onFinish: (() -> Void)? { get set }
    
    func start(duration: TimeInterval)
    func pause() -> TimeInterval
    func resume()
    func reset()
}
