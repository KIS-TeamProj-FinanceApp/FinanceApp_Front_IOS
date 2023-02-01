//
//  MainTabBarController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/18.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController{

    //TabBar 가운데 동그란 버튼
    let centerButton = UIButton()
    
    private lazy var firstViewController: UIViewController = {
        let vc = MainViewController()
        let tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var secondViewController: UIViewController = {
        let vc = KeywordRankViewController()
        let tabBarItem = UITabBarItem(title: "KeyStocks", image: UIImage(systemName: "character"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var thirdViewController: UIViewController = {
        let vc = TradingSearchViewController()
        let tabBarItem = UITabBarItem(title: "Trading", image: UIImage(systemName: "chart.bar.xaxis"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var fourthViewController: UIViewController = {
        let vc = WBRankViewController()
        let tabBarItem = UITabBarItem(title: "WB 따라잡기", image: UIImage(systemName: "infinity"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var fifthViewController: UIViewController = {
        let vc = MyAccountViewController()
        let tabBarItem = UITabBarItem(title: "내 계좌", image: UIImage(systemName: "wallet.pass"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0)
        
        let nav0 = UINavigationController(rootViewController: firstViewController)
        let nav1 = UINavigationController(rootViewController: secondViewController)
        let nav2 = UINavigationController(rootViewController: thirdViewController)
        let nav3 = UINavigationController(rootViewController: fourthViewController)
        let nav4 = UINavigationController(rootViewController: fifthViewController)
        
        setViewControllers([nav0, nav1, nav2, nav3, nav4], animated: true)

    }
}
