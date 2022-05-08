//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Constantin on 07.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
        
    private var statusText: String?
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.frame = CGRect(x: 16, y: 16, width: 150, height: 150)
        profileImage.backgroundColor = .white
        profileImage.image = UIImage(named: "cat_mustache")
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = 75
        profileImage.layer.borderColor = CGColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        profileImage.layer.borderWidth = 3
        profileImage.clipsToBounds = true
        profileImage.isUserInteractionEnabled = true
        return profileImage
    }()
    
    let profileName: UILabel = {
        let profileName = UILabel()
        profileName.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 27, width: (UIScreen.main.bounds.width/2)-10, height: 30)
        profileName.text = "Hipster Cat"
        profileName.textAlignment = .left
        profileName.textColor = .black
        profileName.font = .systemFont(ofSize: 18, weight: .bold)
        return profileName
    }()
    
    var profileStatus: UILabel = {
        var profileStatus = UILabel()
        profileStatus.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 118, width: (UIScreen.main.bounds.width/2)-16, height: 30)
        profileStatus.text = "Waiting for something..."
        profileStatus.textAlignment = .left
        profileStatus.textColor = .gray
        profileStatus.font = .systemFont(ofSize: 14, weight: .regular)
        return profileStatus
    }()
    
    let profileStatusNew: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 148, width: (UIScreen.main.bounds.width/2)-16, height: 40)
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        textField.placeholder = "Enter new status here"
        textField.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let profileButtonStatusShow: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 16, y: 207, width: UIScreen.main.bounds.width-32, height: 50)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        return button
    }()

    @objc func setStatus() {
        profileStatus.text = statusText
        print(profileStatus.text ?? "")
        
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = profileStatusNew.text ?? ""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
    
    func additionViews() {
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(profileStatus)
        addSubview(profileButtonStatusShow)
        addSubview(profileStatusNew)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        additionViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
