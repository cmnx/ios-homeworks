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
        loadLayout()
    }
    
    private func loadLayout() {
    
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.backgroundColor = .white
            stack.alignment = .center
            stack.distribution = .fillEqually
            stack.spacing = 10
            return stack
        }()
    
        lazy var postViewButtonOne: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("View post", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4
            button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            button.layer.shadowOffset.width = 4
            button.layer.shadowOffset.height = 4
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.7
            button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
            return button
        }()
        
        lazy var postViewButtonTwo: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("View post", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4
            button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            button.layer.shadowOffset.width = 4
            button.layer.shadowOffset.height = 4
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.7
            button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(postViewButtonOne)
        stackView.addArrangedSubview(postViewButtonTwo)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postViewButtonOne.widthAnchor.constraint(equalToConstant: 250),
            postViewButtonOne.heightAnchor.constraint(equalToConstant: 50),
            postViewButtonTwo.widthAnchor.constraint(equalToConstant: 250),
            postViewButtonTwo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func clickAction() {
        let postVC = PostViewController()
        let newPost = Post(title: "New post title")
        postVC.titleOfThePost = newPost.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
