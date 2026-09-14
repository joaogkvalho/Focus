//
//  ViewsControllerFactoryProtocol.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation

protocol ViewsControllerFactoryProtocol: AnyObject {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeTimerViewController(flowDelegate: TimerFlowDelegate) -> TimerViewController
    func makeConfigViewController() -> ConfigViewController
}
