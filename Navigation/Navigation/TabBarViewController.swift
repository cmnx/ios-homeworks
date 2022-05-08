//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        self.tabBar.backgroundColor = .white
    }
    
    private func setupControllers() {
        let feedVC = FeedViewController()
        let profileVC = ProfileViewController()
        let feedNC = UINavigationController(rootViewController: feedVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "text.bubble")
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        feedVC.navigationItem.title = "Feed"
        profileVC.navigationItem.title = "Profile"
        
        feedNC.navigationBar.backgroundColor = .white
        profileNC.navigationBar.backgroundColor = .white
        
        viewControllers = [feedNC, profileNC]
    }
    

}
