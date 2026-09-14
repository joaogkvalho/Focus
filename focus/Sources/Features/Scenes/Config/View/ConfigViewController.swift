//
//  ConfigViewController.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 01/09/26.
//

import Foundation
import UIKit

final class ConfigViewController: UIViewController {
    let contentView: ConfigView
    private let viewModel = ConfigViewModel()
    
    init(contentView: ConfigView) {
        self.contentView = contentView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        setupView()
        loadSettings()
        setupActionForBackButton()
    }
    
    private func setupView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        setupActionForSaveConfig()
    }
    
    private func setupActionForBackButton() {
        contentView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    private func setupActionForSaveConfig() {
        contentView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    private func loadSettings() {
        let settings = viewModel.settings
        print(settings)
        
        contentView.workCicleCard.configure(duration: settings.focusDuration)
        contentView.shortPauseCicleCard.configure(duration: settings.shortBreakDuration)
        contentView.longPauseCicleCard.configure(duration: settings.longBreakDuration)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func timeInterval(from text: String?) -> TimeInterval? {
        guard let text else { return nil }
        
        let components = text.split(separator: ":")
        
        guard components.count == 2,
              let minutes = Double(components[0]),
              let seconds = Double(components[1]) else {
            return nil
        }
        
        return (minutes * 60) + seconds
    }
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapSaveButton() {
        guard
            let focusDuration = timeInterval(from: contentView.workCicleCard.workTimeInput.text),
            let shortBreakDuration = timeInterval(from: contentView.shortPauseCicleCard.workTimeInput.text),
            let longBreakDuration = timeInterval(from: contentView.longPauseCicleCard.workTimeInput.text)
        else {
            return
        }
        
        viewModel.saveConfig(
            focusDuration: focusDuration,
            shortBreakDuration: shortBreakDuration,
            longBreakDuration: longBreakDuration
        )
        
        self.navigationController?.popViewController(animated: true)
    }
}
