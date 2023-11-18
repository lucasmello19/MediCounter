//
//  ViewController.swift
//  MediCounter
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MediCounter"
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        let vc1 = FormRegisterViewController(nibName: "FormRegisterViewController", bundle: nil)

        self.viewControllers = [vc, vc1]
    }
}
