//
//  PostViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

struct Post {
    var title: String
}

class PostViewController: UIViewController {

    var titleOfThePost: String? = "Post"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
        navigationItem.title = titleOfThePost
        
        createBarButton()
    }
    
    private func createBarButton() {
        let barItem = UIBarButtonItem(title: "View info", style: .plain, target: self, action: #selector(clickAction))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func clickAction() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }
}
