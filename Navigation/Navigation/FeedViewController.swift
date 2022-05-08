//
//  FeedViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createPostButton()
    }
    
    private func createPostButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.center = view.center
        button.setTitle("View post", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func clickAction() {
        let postVC = PostViewController()
        let newPost = Post(title: "New post title")
        postVC.titleOfThePost = newPost.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
