//
//  MediHoursCountCell.swift
//  MediCounter
//

import UIKit

class MediHoursCountCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var txtFieldHours: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    var idx = 0
    
    let amountPickerView = UIPickerView()
    let amounts: [NSDecimalNumber] = [0.5,1,1.5,2,2.5,3]

    let hourPickerView = UIPickerView()
    let hours = Array(0...23)
    let minutes = Array(0...59)
    
    var shot = ShotVO()
    var isAmountOk = false
    var isHoursOk = false
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == amountPickerView {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == amountPickerView {
            return amounts.count
        } else {
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == amountPickerView {
            return "\(amounts[row]) unidade(s)"
        } else {
            
            if component == 0 {
                return "\(hours[row])h"
            } else {
                return "\(minutes[row])min"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == amountPickerView {
            let amount = amounts[row]
            txtAmount.text = "\(amount)"
            self.shot.amount = amount
            isAmountOk = true
            setupIsOk()

        } else {
            let selectedHour = hours[hourPickerView.selectedRow(inComponent: 0)]
            let selectedMinute = minutes[hourPickerView.selectedRow(inComponent: 1)]
            
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.shot.date)

            components.hour = selectedHour
            components.minute = selectedMinute
            
            self.shot.date = calendar.date(from: components) ?? Date()

            isHoursOk = true
            setupIsOk()

            txtFieldHours.text = String(format: "%02d:%02d", selectedHour, selectedMinute)
        }
    }
    
    func setupCell(idx: Int, shot: ShotVO) {
        self.idx = idx
        self.shot = shot

        hourPickerView.delegate = self
        hourPickerView.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setupHours))
        toolbar.setItems([doneButton], animated: false)

        txtFieldHours.inputView = hourPickerView
        txtFieldHours.inputAccessoryView = toolbar
        
        amountPickerView.delegate = self
        amountPickerView.dataSource = self

        let toolbarAmount = UIToolbar()
        toolbarAmount.sizeToFit()
        
        let doneButtonAmount = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setupAmount))
        toolbarAmount.setItems([doneButtonAmount], animated: false)

        txtAmount.inputView = amountPickerView
        txtAmount.inputAccessoryView = toolbarAmount
    }
    
    @objc func setupHours() {
        let selectedHour = hours[hourPickerView.selectedRow(inComponent: 0)]
        let selectedMinute = minutes[hourPickerView.selectedRow(inComponent: 1)]

        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.shot.date)

        components.hour = selectedHour
        components.minute = selectedMinute
        
        self.shot.date = calendar.date(from: components) ?? Date()

        txtFieldHours.text = String(format: "%02d:%02d", selectedHour, selectedMinute)
        txtFieldHours.resignFirstResponder()
        isHoursOk = true
        setupIsOk()
    }
    
    @objc func setupAmount() {
        let amount = amounts[amountPickerView.selectedRow(inComponent: 0)]
        txtAmount.text = "\(amount)"
        self.shot.amount = amount
        txtAmount.resignFirstResponder()
        isAmountOk = true
        setupIsOk()
    }
    
    func setupIsOk() {
        shot.isOk = isHoursOk && isAmountOk
    }
}
