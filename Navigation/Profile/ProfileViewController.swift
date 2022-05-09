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
        loadLayout()
    }
    
    override func viewWillLayoutSubviews() {
        profileHV.frame  = self.view.safeAreaLayoutGuide.layoutFrame
    }
    
    private func loadLayout() {
        view.addSubview(profileHV)
        profileHV.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            profileHV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHV.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileHV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHV.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
}
