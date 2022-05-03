//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Constantin on 03.05.2022.
//

import UIKit

class ProfileView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var profileLogo: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileBirthday: UILabel!
    @IBOutlet weak var profileCity: UILabel!
    @IBOutlet weak var profileDescription: UITextView!
    
}
