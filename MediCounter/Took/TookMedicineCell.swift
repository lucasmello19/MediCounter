//
//  TookMedicineCell.swift
//  MediCounter
//

import UIKit

class TookMedicineCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var sTook: UISwitch!
    @IBOutlet weak var txtHours: UILabel!
    @IBOutlet weak var txtAmount: UILabel!
    
    // MARK: - Variables
    var shot = Shot()
    
    // MARK: - Setups
    func setupCell(shot: Shot) {
        self.shot = shot
        if !isToday(date: self.shot.date ?? Date()) {
            let calendario = Calendar.current
            let componentsDate = calendario.dateComponents([.hour, .minute, .second], from: self.shot.date ?? Date())
            if let newDate = calendario.date(bySettingHour: componentsDate.hour ?? 0,
                                             minute: componentsDate.minute ?? 0,
                                             second: componentsDate.second ?? 0,
                                             of: Date()) {
                self.shot.date = newDate
            }
            self.shot.took = false
        }
        sTook.isOn = shot.took
        sTook.isUserInteractionEnabled = !shot.took
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let hours = formatter.string(from: shot.date ?? Date())
        txtHours.text = hours
        if let amount = shot.amount{
            txtAmount.text = "Quantidade: \(amount)"
        }
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        let today = calendar.dateComponents([.year, .month, .day], from: Date())
        let date = calendar.dateComponents([.year, .month, .day], from: date)
        
        return today.year == date.year &&
        today.month == date.month &&
        today.day == date.day
    }

    // MARK: - Actions
    @IBAction func onClickSwitch(_ sender: Any) {
        self.shot.took = true
        sTook.isUserInteractionEnabled = false
        _ = DataManager.shared.history(amount: shot.amount ?? NSDecimalNumber(), dateTook: self.shot.date ?? Date(), dateEffective: Date(), medicament: shot.medicament?.medicament ?? String())
        DataManager.shared.save()
    }
}
