//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Constantin on 07.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
        
    override init(frame: CGRect){
        super.init(frame: frame)
        additionViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - views
    
    private var statusText: String?
    
    private let backgndView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
           
    private let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.backgroundColor = .white
        profileImage.image = UIImage(named: "cat_mustache")
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = 50
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
    
    lazy var profileStatusNew: UITextField = {
        let textField = UITextField()
        textField.delegate = self
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
        
// MARK: - layout
    
    private func additionViews() {
        
        [backgndView,
         profileImage,
         profileName,
         profileStatus,
         profileStatusNew,
         profileButtonStatus,
         profileButtonBottom
        ].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            backgndView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            backgndView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            backgndView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgndView.heightAnchor.constraint(equalToConstant: 220),
        //---
            profileImage.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: 16),
            profileImage.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
        //---
            profileName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            profileName.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -16),
            profileName.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: 27),
            profileName.heightAnchor.constraint(equalToConstant: 30),
        //---
            profileStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            profileStatus.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -16),
            profileStatus.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: 48),
            profileStatus.heightAnchor.constraint(equalToConstant: 30),
        //---
            profileStatusNew.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            profileStatusNew.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -16),
            profileStatusNew.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: 78),
            profileStatusNew.heightAnchor.constraint(equalToConstant: 40),
        //---
            profileButtonStatus.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: 16),
            profileButtonStatus.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -16),
            profileButtonStatus.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: 137),
            profileButtonStatus.heightAnchor.constraint(equalToConstant: 50),
        //---
            profileButtonBottom.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor),
            profileButtonBottom.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor),
            profileButtonBottom.bottomAnchor.constraint(equalTo: backgndView.bottomAnchor),
            profileButtonBottom.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension ProfileHeaderView: UITextFieldDelegate {

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.endEditing(true)
            self.profileStatus.text = textField.text
            return true
        }
}


