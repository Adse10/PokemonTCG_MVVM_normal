//
//  CustomTabBarController.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 02/05/2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    lazy var allCardTabBar: UIViewController = {
        let allCardTab = CardListViewController()
        let navigationController = UINavigationController(rootViewController: allCardTab)
        let tabBarItem = UITabBarItem(title: "all.card".localize(), image: nil, selectedImage: nil)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }()
    
    lazy var allSetTabBar: UIViewController = {
       let allSetTab = CardSetListViewController()
        let navigationController = UINavigationController(rootViewController: allSetTab)
        let tabBarItem = UITabBarItem(title: "all.set".localize(), image: nil, selectedImage: nil)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers = [allCardTabBar, allSetTabBar]
    }
}
