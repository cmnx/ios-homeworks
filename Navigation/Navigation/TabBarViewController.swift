//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    let feedVC = FeedViewController()
    let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        self.tabBar.backgroundColor = .white
    }
    
    private func setupControllers() {
        
        let feedNC = UINavigationController(rootViewController: feedVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "text.bubble")
        feedVC.navigationItem.title = "Feed"
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        profileVC.navigationItem.title = "Profile"
        
        viewControllers = [feedNC, profileNC]
    }
    

}
