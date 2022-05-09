//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Constantin on 07.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
        
    private var statusText: String?
    
    private let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let profileName: UILabel = {
        let profileName = UILabel()
        profileName.translatesAutoresizingMaskIntoConstraints = false
        profileName.text = "Hipster Cat"
        profileName.textAlignment = .left
        profileName.textColor = .black
        profileName.font = .systemFont(ofSize: 18, weight: .bold)
        return profileName
    }()
    
    private var profileStatus: UILabel = {
        var profileStatus = UILabel()
        profileStatus.translatesAutoresizingMaskIntoConstraints = false
        profileStatus.text = "Waiting for something..."
        profileStatus.textAlignment = .left
        profileStatus.textColor = .gray
        profileStatus.font = .systemFont(ofSize: 14, weight: .regular)
        return profileStatus
    }()
    
    private lazy var profileStatusNew: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var profileButtonStatus: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var profileButtonBottom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set new status", for: .normal)
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
    
    @objc private func setStatus() {
        profileStatus.text = statusText
        print(profileStatus.text ?? "")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = profileStatusNew.text ?? ""
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        statusText = profileStatusNew.text ?? ""
//        setStatus()
//        return true
//    }
    
    private func additionViews() {
        
        [profileImage,
         profileName,
         profileStatus,
         profileStatusNew,
         profileButtonStatus,
         profileButtonBottom
        ].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
        //---
            profileName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            profileName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            profileName.heightAnchor.constraint(equalToConstant: 30),
        //---
            profileStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            profileStatus.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileStatus.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 118),
            profileStatus.heightAnchor.constraint(equalToConstant: 30),
        //---
            profileStatusNew.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            profileStatusNew.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileStatusNew.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 148),
            profileStatusNew.heightAnchor.constraint(equalToConstant: 40),
        //---
            profileButtonStatus.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileButtonStatus.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileButtonStatus.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 207),
            profileButtonStatus.heightAnchor.constraint(equalToConstant: 50),
        //---
            profileButtonBottom.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            profileButtonBottom.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            profileButtonBottom.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            profileButtonBottom.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        additionViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
