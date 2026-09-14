//
//  SplashViewController.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

final class SplashViewController: UIViewController {
    let contentView: SplashView
    public weak var flowDelegate: SplashFlowDelegate?
    
    init(contentView: SplashView, flowDelegate: SplashFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        startBreatheAnimation()
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.grayBase
        view.addSubview(contentView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SplashViewController {
    private func startBreatheAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0.0, animations: {
            self.contentView.logo.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }, completion: { _ in
            self.flowDelegate?.navigateToHome()
        })
    }
}
