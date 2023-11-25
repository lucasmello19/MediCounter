//
//  RegisterViewController.swift
//  MediCounter
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var medicaments: [Medicament] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
        tableView.allowsMultipleSelectionDuringEditing = false
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Permissão concedida")
            } else {
                print("Permissão negada")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMedicaments()
    }
    
    func updateMedicaments() {
        medicaments = DataManager.shared.medicaments()
        let date = Date()
        for medicament in medicaments {
            if let exp = medicament.expiration, exp < date {
                deleteMedicament(medicament: medicament)
            }
        }
        tableView.reloadData()
    }
    
    func deleteMedicament(medicament: Medicament) {
        let shots = DataManager.shared.shots(medicament: medicament)
        var requestsIdentifiers: [String] = []
        for shot in shots {
            let identifier = "\(medicament.medicament ?? String())\(String(describing: shot.amount))\(shot.date ?? Date())"
            requestsIdentifiers.append(identifier)
            DataManager.shared.deleteShot(shot: shot)
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: requestsIdentifiers)
        DataManager.shared.deleteMedicament(medicament: medicament)
    }
    
    @IBAction func onClickNewRegister(_ sender: Any) {
        let vc = FormRegisterViewController(nibName: "FormRegisterViewController", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RegisterCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RegisterCell {
            cell.setupName(medicament: medicaments[indexPath.row].medicament ?? String())
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Apagar") { (action, view, completionHandler) in
            let medicament = self.medicaments[indexPath.row]
            self.deleteMedicament(medicament: medicament)
            self.updateMedicaments()
            completionHandler(true)
        }
        delete.backgroundColor = UIColor.red
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TookMedicineViewController(nibName: "TookMedicineViewController", bundle: nil)
        vc.medicament = medicaments[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

