//
//  TabBarViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = CodeMainViewController()
        
        mainVC.tabBarItem.title = "Main"
        mainVC.tabBarItem.image = UIImage(systemName: "flame")
        mainVC.navigationItem.title = "여미의 상영관"
       
        
        let listVC = DetailViewController()
        listVC.tabBarItem.image = UIImage(systemName: "flame")
        
       
        
        let profileVC = ProfileViewController()
        profileVC.navigationItem.title = "프로필 설정"
        profileVC.tabBarItem.title = "설정"
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        let mainVCHome = UINavigationController(rootViewController: mainVC)
        let profileVCHome = UINavigationController(rootViewController: profileVC)
        
        
        self.tabBar.tintColor = UIColor.white // tab bar icon tint color
        self.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.blue
        setViewControllers([mainVCHome, listVC, profileVCHome], animated: false)
        
    }
}
