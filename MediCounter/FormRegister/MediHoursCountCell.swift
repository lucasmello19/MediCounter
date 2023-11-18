//
//  MediHoursCountCell.swift
//  MediCounter
//

import UIKit

class MediHoursCountCell: UITableViewCell {

    @IBOutlet weak var idxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(index: Int) {
        idxLabel.text = "\(index)-"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
