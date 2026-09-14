//
//  ViewsControllerFactory.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

final class ViewsControllerFactory: ViewsControllerFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let contentView = SplashView()
        let viewController = SplashViewController(contentView: contentView, flowDelegate: flowDelegate)
        
        return viewController
    }
    
    func makeTimerViewController(flowDelegate: TimerFlowDelegate) -> TimerViewController {
        let timerService = TimerService()
        let notificationService = NotificationsService()
        let settings = ConfigViewModel()
        
        let contentView = TimerView()
        let viewModel = TimerViewModel(timerService: timerService, notificationService: notificationService, settings: settings)
        let viewController = TimerViewController(viewModel: viewModel, contentView: contentView, flowDelegate: flowDelegate)
        
        return viewController
    }
    
    func makeConfigViewController() -> ConfigViewController {
        let contentView = ConfigView()
        let viewController = ConfigViewController(contentView: contentView)
        
        return viewController
    }
}
