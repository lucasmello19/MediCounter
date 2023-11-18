//
//  FormRegisterViewController.swift
//  MediCounter
//

import UIKit

class FormRegisterViewController: UIViewController {
    var hoursCount: [String] = [String()]
    @IBOutlet weak var tableView: AutoSizingTableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MediHoursCountCell", bundle: nil), forCellReuseIdentifier: "MediHoursCountCell")
        tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoApareceu(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDesapareceu(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tocouFora))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tocouFora() {
        // Este método será chamado quando tocar fora do campo de texto
        view.endEditing(true)
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
        hoursCount.append(String())
        tableView.reloadData()
    }
}

extension FormRegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hoursCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MediHoursCountCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MediHoursCountCell {
            cell.setupCell(index: indexPath.row + 1)
            return cell
        } else {
            return UITableViewCell()
        }
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
