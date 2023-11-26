//
//  TookMedicineViewController.swift
//  MediCounter
//

import UIKit

class TookMedicineViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: AutoSizingTableView!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - Variales
    var medicament = Medicament()
    var shots: [Shot] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setups
    func setupView() {
        self.title = medicament.medicament
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "TookMedicineCell", bundle: nil), forCellReuseIdentifier: "TookMedicineCell")
        tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.isScrollEnabled = false
        shots = DataManager.shared.shots(medicament: self.medicament)
    }
}

extension TookMedicineViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - TableView Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TookMedicineCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TookMedicineCell {
            cell.setupCell(shot: shots[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
