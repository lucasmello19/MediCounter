//
//  TookMedicineCell.swift
//  MediCounter
//

import UIKit

class TookMedicineCell: UITableViewCell {
    @IBOutlet weak var sTook: UISwitch!
    @IBOutlet weak var txtHours: UILabel!
    @IBOutlet weak var txtAmount: UILabel!
    
    var shot = Shot()
    
    func setupCell(shot: Shot) {
        self.shot = shot
        if !isToday(date: self.shot.date ?? Date()) {
            self.shot.date = Date()
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
    
    @IBAction func onClickSwitch(_ sender: Any) {
        self.shot.took = true
        sTook.isUserInteractionEnabled = false
        _ = DataManager.shared.history(amount: shot.amount ?? NSDecimalNumber(), date: Date(), medicament: shot.medicament?.medicament ?? String())
        DataManager.shared.save()
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        let today = calendar.dateComponents([.year, .month, .day], from: Date())
        let date = calendar.dateComponents([.year, .month, .day], from: date)
        
        return today.year == date.year &&
        today.month == date.month &&
        today.day == date.day
    }
}
