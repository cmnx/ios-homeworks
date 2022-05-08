//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHV = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        profileHV.frame  = self.view.safeAreaLayoutGuide.layoutFrame
        profileHV.backgroundColor = .lightGray
        view.addSubview(profileHV)
    }
    
}
