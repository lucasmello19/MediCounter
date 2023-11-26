//
//  ViewController.swift
//  MediCounter
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let register = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        let pills = UIImage(named: "pills")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        
        register.tabBarItem = setupTabBarItem(titulo: "Medicamentos", 
                                              imagem: pills,
                                              cor: .gray)
        
        let history = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        let historyImage = UIImage(named: "history")?.withRenderingMode(.alwaysOriginal) ?? UIImage()

        history.tabBarItem = setupTabBarItem(titulo: "Histórico",
                                             imagem: historyImage,
                                             cor: .gray)

        let navRegister = UINavigationController(rootViewController: register)
        let navHistory = UINavigationController(rootViewController: history)
        
        self.viewControllers = [navRegister, navHistory]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }
    
    func setupTabBarItem(titulo: String, imagem: UIImage, cor: UIColor) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: titulo, image: imagem, selectedImage: nil)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        return tabBarItem
    }
}
