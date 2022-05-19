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
    var blackoutViewPortrait = [NSLayoutConstraint]()
    var blackoutViewLandscape = [NSLayoutConstraint]()
    
    private let backgndView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var blackoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.isHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(collapseProfileImage)))
        return view
    }()
    
    private let maskImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
           
    private lazy var profileImage: UIImageView = {
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
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandProfileImage)))
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
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        textField.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        statusText = ""
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
        
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let confImageButton = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: confImageButton)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(collapseProfileImage), for: .touchUpInside)
        return button
    }()
    
// MARK: - functions - text field
    
    @objc private func setStatus() {
        if statusText == "" {
            profileStatusNew.attributedPlaceholder = NSAttributedString(
                string: "Cannot be empty!",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            profileStatusNew.text = ""
        } else {
            profileStatusNew.attributedPlaceholder = NSAttributedString(
                string: "Enter new status here",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            profileStatus.text = statusText
            profileStatusNew.text = ""
            statusText = ""
        }
        print(profileStatus.text ?? "")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = profileStatusNew.text ?? ""
    }
    
// MARK: - functions - gestures
    
    @objc private func expandProfileImage() {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut) {
            
            self.blackoutView.isHidden = false
            
            self.profileImage.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            
            var size: CGFloat = 0
            
            if UIDevice.current.orientation.isPortrait {
                
                self.profileImage.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                
                size = UIScreen.main.bounds.width
                self.profileImage.layer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
                
                NSLayoutConstraint.deactivate(self.blackoutViewLandscape)
                NSLayoutConstraint.activate(self.blackoutViewPortrait)
                   
            } else {
                
                self.profileImage.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 30)
                
                size = UIScreen.main.bounds.height - 80
                self.profileImage.layer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
                
                NSLayoutConstraint.deactivate(self.blackoutViewPortrait)
                NSLayoutConstraint.activate(self.blackoutViewLandscape)
               
            }
            
            self.profileImage.layer.cornerRadius = 0
            self.layoutIfNeeded()
        
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           animations: {
                self.closeButton.backgroundColor = .red.withAlphaComponent(1)
            })
        }
    }

    @objc private func collapseProfileImage(){
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut) {
            
            self.blackoutView.isHidden = true
            
            self.profileImage.layer.position = self.maskImageView.layer.position
            self.profileImage.layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.profileImage.layer.cornerRadius = self.profileImage.bounds.width / 2
            
            self.layoutIfNeeded()
        }
    }
        
// MARK: - layout
    
    let viewHeight: CGFloat = 220
    
    private func additionViews() {
        
        [backgndView,
         profileName,
         profileStatus,
         profileStatusNew,
         profileButtonStatus,
         blackoutView,
         maskImageView,
         profileImage
        ].forEach { addSubview($0) }
        
        blackoutView.addSubview(closeButton)
        
        blackoutViewPortrait = [
            blackoutView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            blackoutView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            closeButton.topAnchor.constraint(equalTo: blackoutView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor)
        ]
        blackoutViewLandscape = [
            blackoutView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            blackoutView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            closeButton.topAnchor.constraint(equalTo: blackoutView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -100)
        ]
        
        NSLayoutConstraint.activate(blackoutViewPortrait)
        
        NSLayoutConstraint.activate([
            backgndView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            backgndView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            backgndView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgndView.heightAnchor.constraint(equalToConstant: viewHeight),
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
            maskImageView.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: 16),
            maskImageView.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: 16),
            maskImageView.widthAnchor.constraint(equalToConstant: 100),
            maskImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - extensions

extension ProfileHeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        
        if self.statusText == "" {
            self.profileStatusNew.attributedPlaceholder = NSAttributedString(
                string: "Cannot be empty!",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.profileStatusNew.text = ""
        } else {
            self.profileStatusNew.attributedPlaceholder = NSAttributedString(
                string: "Enter new status here",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            self.profileStatus.text = textField.text
            self.profileStatusNew.text = ""
            self.statusText = ""
        }
        return true
    }
}


