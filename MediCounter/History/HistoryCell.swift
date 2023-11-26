//
//  HistoryCell.swift
//  MediCounter
//

import UIKit

class HistoryCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lblMedicament: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateAg: UILabel!
    @IBOutlet weak var lblDateEffective: UILabel!
    
    // MARK: - Setups
    func setup(history: History) {
        lblMedicament.text = "Histórico do Medicamento: \(history.medicament ?? String())"
        lblDate.text = "Data: \(getDate(date: history.dateEffective ?? Date()))"
        lblDateAg.text = "Horário Agendado: \(getHour(date: history.dateTook ?? Date()))"
        lblDateEffective.text = "Horário Efetivo: \(getHour(date: history.dateEffective ?? Date()))"
        lblAmount.text = "Dose admininstrada: \(history.amount ?? NSDecimalNumber())"
    }
    
    func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone.current
        let dataFormatada = dateFormatter.string(from: date)
        
        return dataFormatada
    }
    
    func getHour(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone.current
        let dataFormatada = dateFormatter.string(from: date)
        
        return dataFormatada
    }
}
