//
//  TimerView.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

final class TimerUIView: UIView {
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    private let timeLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        setupLayers()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers() {
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = Colors.grayLight.cgColor
        trackLayer.lineWidth = 16

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = Colors.grayBase.cgColor
        progressLayer.lineWidth = 16
        progressLayer.lineCap = .round
        
        progressLayer.strokeEnd = 1.0

       layer.addSublayer(trackLayer)
       layer.addSublayer(progressLayer)
    }
    
    private func setupTimeLabel() {
        timeLabel.font = Fonts.titleGiant()
        timeLabel.textAlignment = .center
        timeLabel.textColor = Colors.grayBase
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(
            x: bounds.midX, y: bounds.midY
        )
        
        let radius = min(bounds.width, bounds.height) / 2 - 12
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: .pi * 1.5,
            clockwise: true
        )
        
        trackLayer.frame = bounds
        trackLayer.path = path.cgPath
        
        progressLayer.frame = bounds
        progressLayer.path = path.cgPath
    }
    
    func setProgress(_ progress: CGFloat, animated: Bool = true) {
        let value = min(max(progress, 0), 1)
        let newStart = 1 - value
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeStart")
            
            animation.fromValue = progressLayer.presentation()?.strokeStart ?? progressLayer.strokeStart
            animation.toValue = newStart
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            
            progressLayer.add(animation, forKey: "progress")
        }
        
        progressLayer.strokeStart = newStart
    }
    
    func setTime(time: String) {
        timeLabel.text = time
    }
}
