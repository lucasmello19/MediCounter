//
//  HistoryCell.swift
//  MediCounter
//
//  Created by Lucas Mello on 25/11/23.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var lblMedicament: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    func setup(history: History) {
        lblMedicament.text = history.medicament
        
        let dataFormatada = setupDate(date: history.date ?? Date())

        lblDate.text = "Data: \(dataFormatada)"
        lblAmount.text = "Dose admininstrada: \(history.amount ?? NSDecimalNumber())"
    }
    
    func setupDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone.current
        let dataFormatada = dateFormatter.string(from: date)
        
        return dataFormatada
    }
}
