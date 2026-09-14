//
//  SplashView.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

final class SplashView: UIView {
    let logo: UILabel = {
        let label = UILabel()
        label.text = "Focus".uppercased()
        label.font = Fonts.titleLarge()
        label.textColor = Colors.background
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(logo)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -24)
        ])
    }
}
