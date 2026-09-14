//
//  TimeView.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

final class TimerView: UIView {
    let logo: UILabel = {
        let label = UILabel()
        label.text = "Focus".uppercased()
        label.font = Fonts.titleLarge()
        label.textColor = Colors.grayBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "gear",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        ), for: .normal)
        button.tintColor = Colors.grayBase
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logo, settingsButton])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "play.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)
        ), for: .normal)
        button.tintColor = Colors.background
        button.backgroundColor = Colors.grayBase
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        return button
    }()
    
    let pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "pause.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)
        ), for: .normal)
        button.tintColor = Colors.background
        button.backgroundColor = Colors.grayBase
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "gobackward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)
        ), for: .normal)
        button.tintColor = Colors.background
        button.backgroundColor = Colors.grayBase
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pauseButton, resetButton, startButton])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(headerStack)
        addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            headerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            buttonsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -86)
        ])
    }
}
