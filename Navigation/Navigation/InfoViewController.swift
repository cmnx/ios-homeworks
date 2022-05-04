//
//  InfoViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        createPostButton()
    }
    
    private func createPostButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.center = view.center
        button.setTitle("View alert", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func clickAction() {
        let alert = UIAlertController(title: "Alert!", message: "Select the action below", preferredStyle: .alert)
        let leftButton = UIAlertAction(title: "Left", style: .default) { _ in
            print("Alert button click: Left")
        }
        let rightButton = UIAlertAction(title: "Right", style: .default) { _ in
            print("Alert button click: Right")
        }
        alert.addAction(leftButton)
        alert.addAction(rightButton)
        present(alert, animated: true)
    }
}
