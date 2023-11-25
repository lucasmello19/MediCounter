//
//  FormRegisterViewController.swift
//  MediCounter
//

import UIKit

class FormRegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var shots: [ShotVO] = [ShotVO()]
    
    @IBOutlet weak var tableView: AutoSizingTableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtMedicament: UITextField!
    @IBOutlet weak var txtAmountDays: UITextField!
    
    let amountDaysPicker = UIPickerView()
    var amountDays: [Any] = ["uso contínuo"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MediHoursCountCell", bundle: nil), forCellReuseIdentifier: "MediHoursCountCell")
        tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoApareceu(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDesapareceu(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        txtAmountDays.inputView = amountDaysPicker
        amountDaysPicker.delegate = self
        amountDaysPicker.dataSource = self
        for i in 1...100 {
            amountDays.append(i)
        }
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setupExpitarionDay))
        toolbar.setItems([doneButton], animated: false)
        txtAmountDays.inputAccessoryView = toolbar
    }
    
    @objc func setupExpitarionDay() {
        let amountDay = amountDays[amountDaysPicker.selectedRow(inComponent: 0)]
        txtAmountDays.text = "\(amountDay)"
        txtAmountDays.resignFirstResponder()
    }
        
    @objc func tecladoApareceu(_ notification: Notification) {
        if let tecladoSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tecladoSize.height, right: 0)
        }
    }
    
    @objc func tecladoDesapareceu(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    @IBAction func onClickAdd(_ sender: Any) {
        shots.append(ShotVO())
        tableView.reloadData()
    }
    
    func getExperationDate() -> Date? {
        let expValue = amountDays[amountDaysPicker.selectedRow(inComponent: 0)]
        if let exp = expValue as? Int {
            let calendario = Calendar.current
            if let configDate = calendario.date(bySettingHour: 23, minute: 59, second: 59, of: Date()) {
                if let expirationDate = calendario.date(byAdding: .day, value: exp, to: configDate) {
                    return expirationDate
                }
            }
        }
        return nil
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        let medicament = DataManager.shared.medicament(name: txtMedicament.text ?? String(), expiration: getExperationDate())
        for shot in shots {
            _ = DataManager.shared.shot(amount: shot.amount, date: shot.date, medicament: medicament)
            let identifier = "\(medicament.medicament ?? String())\(shot.amount)\(shot.date)"
            self.setupAlarm(title: "MediCount", body: "Tomar \(shot.amount) de \(medicament.medicament ?? String())", date: shot.date, identifier: identifier)
        }
        DataManager.shared.save()
        self.navigationController?.popViewController(animated: true)
    }
}

extension FormRegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MediHoursCountCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MediHoursCountCell {
            cell.setupCell(idx: indexPath.row, shot: shots[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Adicione aqui a lógica para a ação de exclusão
            print("Delete action triggered for row \(indexPath.row)")
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    
    func setupAlarm(title: String, body: String, date: Date, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Erro ao configurar o alarme diário: \(error.localizedDescription)")
            } else {
                print("Alarme diário configurado com sucesso!")
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return amountDays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let day = amountDays[row] as? Int {
            return "\(amountDays[row]) dia(s)"
        } else {
            return "\(amountDays[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            txtAmountDays.text = "\(amountDays[row])"
    }
}

final public class AutoSizingTableView: UITableView {
    
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
