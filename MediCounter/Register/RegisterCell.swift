//
//  RegisterCell.swift
//  MediCounter
//

import UIKit

class RegisterCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    func setupName(medicament: String) {
        name.text = medicament
    }
}
