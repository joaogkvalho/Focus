//
//  CicleCardView.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 01/09/26.
//

import Foundation
import UIKit

final class CircleCardView: UIView {
    private var selectedMinutes: Int = 25
    
    let workCicleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.titleMedium()
        label.textColor = Colors.grayBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let workCicleDescription: UILabel = {
        let label = UILabel()
        label.font = Fonts.textSm()
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let workTimeInput: UITextField = {
        let field = UITextField()
        field.font = Fonts.titleLarge()
        field.textColor = Colors.grayBase
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    let timeOptions = [
        1,
        2,
        5,
        10,
        15,
        20,
        25,
        30,
        35,
        40,
        45,
        50,
        55,
        60
    ]
    
    init(title: String, description: String, time: Int) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = Colors.grayLight.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        workCicleLabel.text = title
        workCicleDescription.text = description
        
        selectedMinutes = time
        workTimeInput.text = String(format: "%02d:00", time)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(workCicleLabel)
        addSubview(workCicleDescription)
        addSubview(workTimeInput)
        
        setupTimeLabel()
        
        NSLayoutConstraint.activate([
            workCicleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            workCicleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            workCicleDescription.topAnchor.constraint(equalTo: workCicleLabel.bottomAnchor, constant: 2),
            workCicleDescription.leadingAnchor.constraint(equalTo: workCicleLabel.leadingAnchor),
            workCicleDescription.widthAnchor.constraint(equalToConstant: 194),
            
            workTimeInput.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            workTimeInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
    }
    
    func configure(duration: TimeInterval) {
        let totalSeconds = Int(duration)
        
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        workTimeInput.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func setupTimeLabel() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIButton(type: .system)
        doneButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        doneButton.tintColor = traitCollection.userInterfaceStyle == .dark ? Colors.grayLight : Colors.grayBase
        
        doneButton.addTarget(self, action: #selector(didSelectTime), for: .touchUpInside)
        
        let doneBarButton = UIBarButtonItem(customView: doneButton)
        toolbar.setItems([doneBarButton], animated: false)
        
        workTimeInput.inputView = timePicker
        workTimeInput.inputAccessoryView = toolbar
        
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    private func updateTimeInput() {
        workTimeInput.text = String(
            format: "%02d:00",
            selectedMinutes
        )
    }
    
    @objc
    private func didSelectTime() {
        let selectedRow = timePicker.selectedRow(inComponent: 0)
        
        selectedMinutes = timeOptions[selectedRow]
        updateTimeInput()
        
        workTimeInput.resignFirstResponder()
    }
}

extension CircleCardView: UITextFieldDelegate {
    func textField( _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String ) -> Bool {
        return false
    }
}

extension CircleCardView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()

        label.text = "\(timeOptions[row]) min"
        label.font = Fonts.titleLarge()
        label.textAlignment = .center

        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMinutes = timeOptions[row]
        updateTimeInput()
    }
}
