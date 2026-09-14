//
//  ConfigView.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 01/09/26.
//

import Foundation
import UIKit

final class ConfigView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "arrow.left",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        ), for: .normal)
        button.tintColor = Colors.grayBase
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Configurações".uppercased()
        label.font = Fonts.titleLarge()
        label.textColor = Colors.grayBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Personalize os tempos dos seus ciclos para se adequar ao seu foco."
        label.numberOfLines = 2
        label.font = Fonts.textSm()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let ciclesLabel: UILabel = {
        let label = UILabel()
        label.text = "Ciclos".uppercased()
        label.font = Fonts.titleMedium()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let workCicleCard: CircleCardView = {
        let card = CircleCardView(
            title: "Foco (work)".uppercased(),
            description: "Tempo de foco para realizar suas tarefas.",
            time: 25
        )
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return card
    }()
    
    let shortPauseCicleCard: CircleCardView = {
        let card = CircleCardView(
            title: "Pausa".uppercased(),
            description: "Pequenas pausas para recarregar sua mente.",
            time: 5
        )
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return card
    }()
    
    let longPauseCicleCard: CircleCardView = {
        let card = CircleCardView(
            title: "Pausa longa".uppercased(),
            description: "Pausas mais longas para descansar profundamente.",
            time: 15
        )
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return card
    }()
    
    private lazy var ciclesStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                workCicleCard,
                shortPauseCicleCard,
                longPauseCicleCard
            ]
        )
        
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar".uppercased(), for: .normal)
        button.titleLabel?.font = Fonts.titleSmall()
        button.tintColor = Colors.grayLight
        button.backgroundColor = Colors.grayBase
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backButton)
        addSubview(titleLable)
        addSubview(descriptionLabel)
        addSubview(ciclesLabel)
        addSubview(ciclesStack)
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            
            titleLable.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            titleLable.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -84),
            
            ciclesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            ciclesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            ciclesStack.topAnchor.constraint(equalTo: ciclesLabel.bottomAnchor, constant: 10),
            ciclesStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            ciclesStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
