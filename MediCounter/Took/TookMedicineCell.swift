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
        sTook.isOn = shot.took
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let hours = formatter.string(from: shot.date ?? Date())
        txtHours.text = hours
        txtAmount.text = "Quantidade: \(shot.amount)"
    }

    @IBAction func onClickSwitch(_ sender: Any) {
        
    }
}
