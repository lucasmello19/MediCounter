//
//  RegisterViewController.swift
//  MediCounter
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
        tableView.allowsMultipleSelectionDuringEditing = false
    }

    @IBAction func onClickNewRegister(_ sender: Any) {
        let vc = FormRegisterViewController(nibName: "FormRegisterViewController", bundle: nil)

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RegisterCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RegisterCell {

            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Ações de deslizamento à direita
        let acao1 = UIContextualAction(style: .normal, title: "Editar") { (action, view, completionHandler) in
            // Lógica da ação 1
            completionHandler(true)
        }
        acao1.backgroundColor = UIColor.blue

        let acao2 = UIContextualAction(style: .normal, title: "Apagar") { (action, view, completionHandler) in
            // Lógica da ação 2
            completionHandler(true)
        }
        acao2.backgroundColor = UIColor.red

        // Configuração das ações de deslizamento à direita
        let configuracao = UISwipeActionsConfiguration(actions: [acao2, acao1])
        configuracao.performsFirstActionWithFullSwipe = false
        return configuracao
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TookMedicineViewController(nibName: "TookMedicineViewController", bundle: nil)

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

