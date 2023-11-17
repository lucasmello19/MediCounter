//
//  RegisterViewController.swift
//  MediCounter
//
//  Created by Lucas Mello on 17/11/23.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
    }

    @IBAction func onClickNewRegister(_ sender: Any) {
        let vc = FormRegisterViewController(nibName: "FormRegisterViewController", bundle: nil)

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterViewController: UITableViewDataSource {
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
}

