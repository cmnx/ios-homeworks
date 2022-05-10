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
    
    private func loadLayout() {
        view.addSubview(profileHV)
        profileHV.backgroundColor = .lightGray
        profileHV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileHV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHV.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
}
