//
//  TimeViewController.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

final class TimerViewController: UIViewController {
    private let viewModel: TimerViewModel
    let contentView: TimerView
    let flowDelegate: TimerFlowDelegate
    
    private var indicatorBottomConstraint: NSLayoutConstraint?
    private var indicatorLeadingConstraint: NSLayoutConstraint?
    
    let ciclesCountLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.titleMedium()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let timer: TimerUIView = {
        let timer = TimerUIView()
        timer.translatesAutoresizingMaskIntoConstraints = false
        
        return timer
    }()
    
    let cicleIndicator: CircleIndicatorView = {
        let cicleIndicator = CircleIndicatorView()
        cicleIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return cicleIndicator
    }()
    
    init(viewModel: TimerViewModel, contentView: TimerView, flowDelegate: TimerFlowDelegate) {
        self.viewModel = viewModel
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.background
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        
        setupView()
        bindViewModel()
        setupCicleIndicator()
        setupCicleLabel()
        setupCiclesCount()
        setupActionsForButtons()
        
        viewModel.requestNotificationPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.loadSettings()
        viewModel.restoreTimerState()
    }
    
    private func setupActionsForButtons() {
        contentView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        contentView.pauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        contentView.resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        
        contentView.settingsButton.addTarget(self, action: #selector(ditTapSettingsButton), for: .touchUpInside)
    }
    
    private func setupView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentView)
        view.addSubview(ciclesCountLabel)
        view.addSubview(timer)
        view.addSubview(cicleIndicator)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ciclesCountLabel.bottomAnchor.constraint(equalTo: timer.topAnchor, constant: -12),
            ciclesCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timer.widthAnchor.constraint(equalToConstant: 300),
            timer.heightAnchor.constraint(equalToConstant: 300),
            
            cicleIndicator.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 32),
            cicleIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupCiclesCount() {
        ciclesCountLabel.text = "Ciclo \(viewModel.completedPomodoros.description) de 4"
    }
    
    private func setupCicleIndicator() {
        var label: UILabel
        
        switch viewModel.mode {
        case .work:
            label = cicleIndicator.focusLabel
        case .shortBreak:
            label = cicleIndicator.shortBreakLabel
        case .longBreak:
            label = cicleIndicator.longBreakLabel
        }
        
        indicatorBottomConstraint?.isActive = false
        indicatorLeadingConstraint?.isActive = false
        
        indicatorBottomConstraint = cicleIndicator.indicator.bottomAnchor.constraint(
            equalTo: label.topAnchor, constant: -6
        )
        
        indicatorLeadingConstraint = cicleIndicator.indicator.leadingAnchor.constraint(
            equalTo: label.leadingAnchor
        )
        
        indicatorBottomConstraint?.isActive = true
        indicatorLeadingConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.25) {
            self.cicleIndicator.indicator.layoutIfNeeded()
        }
    }
    
    private func setupCicleLabel() {
        switch viewModel.mode {
        case .work:
            cicleIndicator.focusLabel.textColor = Colors.grayBase
            cicleIndicator.shortBreakLabel.textColor = UIColor.systemGray
            cicleIndicator.longBreakLabel.textColor = UIColor.systemGray
        case .shortBreak:
            cicleIndicator.shortBreakLabel.textColor = Colors.grayBase
            cicleIndicator.focusLabel.textColor = UIColor.systemGray
            cicleIndicator.longBreakLabel.textColor = UIColor.systemGray
        case .longBreak:
            cicleIndicator.longBreakLabel.textColor = Colors.grayBase
            cicleIndicator.shortBreakLabel.textColor = UIColor.systemGray
            cicleIndicator.focusLabel.textColor = UIColor.systemGray
        }
    }
    
    private func bindViewModel() {
        viewModel.onTimeUpdate = { [weak self] time in
            DispatchQueue.main.async {
                self?.timer.setTime(time: time)
            }
        }
        
        viewModel.onTimerFinished = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }

                self.timer.setProgress(1)
                self.setupCicleIndicator()
                self.setupCicleLabel()
                self.setupCiclesCount()
            }
        }
        
        viewModel.onTick = { [weak self] remaining in
            DispatchQueue.main.async {
                let progress = CGFloat(remaining) / CGFloat(self?.viewModel.duration ?? 1)
                self?.timer.setProgress(progress)
            }
        }
        
        viewModel.refreshUI()
    }
    
    @objc
    private func didTapStartButton() {
        viewModel.start()
    }
    
    @objc
    private func didTapPauseButton() {
        viewModel.pause()
    }
    
    @objc
    private func didTapResetButton() {
        viewModel.reset()
        self.timer.setProgress(viewModel.duration)
    }
    
    @objc
    private func ditTapSettingsButton() {
        flowDelegate.navigateToSettings()
    }
}
