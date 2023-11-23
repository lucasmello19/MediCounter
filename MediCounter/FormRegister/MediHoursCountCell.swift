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
    let amounts = Array([1,2,3])

    let hourPickerView = UIPickerView()
    let hours = Array(0...23)
    
//    let minutePickerView = UIPickerView()
    let minutes = Array(0...59)
    
    var shot = ShotVO()
    
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
            txtAmount.text = "\(amounts[row])"
        } else {
            let selectedHour = hours[hourPickerView.selectedRow(inComponent: 0)]
            let selectedMinute = minutes[hourPickerView.selectedRow(inComponent: 1)]
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
    }
    
    @objc func setupAmount() {
        let amount = amounts[amountPickerView.selectedRow(inComponent: 0)]
        txtAmount.text = "\(amount)"
        self.shot.amount = Int16(amount)
        txtAmount.resignFirstResponder()
    }
}
