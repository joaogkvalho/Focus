//
//  CicleIndicatorView.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 03/09/26.
//

import Foundation
import UIKit

final class CircleIndicatorView: UIView {
    private var indicatorBottomConstraints: NSLayoutConstraint?
    
    let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.grayBase
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let focusLabel: UILabel = {
        let label = UILabel()
        label.text = "Foco".uppercased()
        label.font = Fonts.titleMedium()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let shortBreakLabel: UILabel = {
        let label = UILabel()
        label.text = "Pausa".uppercased()
        label.font = Fonts.titleMedium()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let longBreakLabel: UILabel = {
        let label = UILabel()
        label.text = "Pausa longa".uppercased()
        label.font = Fonts.titleMedium()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var cicleIndicatorStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [focusLabel, shortBreakLabel, longBreakLabel])
        stack.axis = .horizontal
        stack.spacing = 14
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(cicleIndicatorStack)
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            cicleIndicatorStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            indicator.widthAnchor.constraint(equalToConstant: 48),
            indicator.heightAnchor.constraint(equalToConstant: 6),
        ])
    }
}
