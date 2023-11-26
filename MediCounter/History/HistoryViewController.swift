//
//  HistoryViewController.swift
//  MediCounter
//

import UIKit

class HistoryViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var historys: [History] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Histórico"
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historys = DataManager.shared.historys()
        tableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - TableView Datasource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HistoryCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryCell {
            let history = historys[indexPath.row]
            cell.setup(history: history)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
