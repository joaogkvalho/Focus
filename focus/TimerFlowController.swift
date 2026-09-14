//
//  TimerFlowController.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

class TimerFlowController {
    private var navigationController: UINavigationController?
    private var viewsControllerFactory: ViewsControllerFactoryProtocol
    
    public init() {
        self.viewsControllerFactory = ViewsControllerFactory()
    }
    
    func start() -> UINavigationController? {
        let startViewController = viewsControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}

extension TimerFlowController: SplashFlowDelegate {
    func navigateToHome() {
        let viewController = viewsControllerFactory.makeTimerViewController(flowDelegate: self)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TimerFlowController: TimerFlowDelegate {
    func navigateToSettings() {
        let settingsViewController = viewsControllerFactory.makeConfigViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
