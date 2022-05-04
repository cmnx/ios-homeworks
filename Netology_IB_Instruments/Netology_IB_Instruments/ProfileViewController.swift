//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Constantin on 03.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        if let profileView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView {
            profileView.frame = CGRect(x: 50, y: 50, width: screenWidth-100 , height: screenHeight-100)
            view.addSubview(profileView)
        }
    }
}
