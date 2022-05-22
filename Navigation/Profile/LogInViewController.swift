//
//  LogInViewController.swift
//  Navigation
//
//  Created by Constantin on 11.05.2022.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout()
    }
    
    private let nc = NotificationCenter.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    let colorSet = UIColor.init(rgb: 0x4885CC)
    
// MARK: - layout
    
    private func loadLayout() {
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [logoImageView,
         loginStackView,
         passwordWarningLabel,
         logInButton
        ].forEach { contentView.addSubview($0) }
        
        loginStackView.addArrangedSubview(loginTF)
        loginStackView.addArrangedSubview(passwordTF)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
        //---
            loginStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),
        //---
            loginTF.widthAnchor.constraint(equalTo: loginStackView.widthAnchor),
            passwordTF.widthAnchor.constraint(equalTo: loginStackView.widthAnchor),
        //---
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //---
            passwordWarningLabel.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            passwordWarningLabel.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 3)
        ])
    }
    
// MARK: - views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .white
        return content
    }()
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.clipsToBounds = true
        return stack
    }()
    
    private lazy var loginTF: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
//        textField.tintColor = accentColor //deprecated
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email or phone"
        textField.addTarget(self, action: #selector(login), for: .touchUpInside)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
//        textField.tintColor = accentColor //deprecated
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.addTarget(self, action: #selector(login), for: .touchUpInside)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordWarningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The password must contain at least 8 characters"
        label.textAlignment = .left
        label.textColor = .red
        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        switch(button.state) {
            case .normal:
                button.setBackgroundImage(UIImage(named: "blue_pixel"), for: button.state)
                button.layer.opacity = 1.0
            case .selected, .highlighted, .disabled:
                button.setBackgroundImage(UIImage(named: "blue_pixel"), for: button.state)
                button.layer.opacity = 0.8
            default:
                button.setBackgroundImage(UIImage(named: "blue_pixel"), for: button.state)
                button.layer.opacity = 1.0
        }
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
   
// MARK: - functions
    
    @objc private func login() {
        if checkLoginTextFields() {
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func checkLoginTextFields () -> Bool {
        
        loginTF.backgroundColor = .systemGray6
        passwordTF.backgroundColor = .systemGray6
        loginTF.attributedPlaceholder = NSAttributedString(
            string: "Email or phone",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText ])
        passwordTF.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText ])
        passwordWarningLabel.isHidden = true
        
        guard loginTF.text != "" else {
            loginTF.attributedPlaceholder = NSAttributedString(
                string: "Cannot be empty!",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            loginTF.backgroundColor = .systemRed.withAlphaComponent(0.6)
            return false
        }
        guard passwordTF.text != "" else {
            passwordTF.attributedPlaceholder = NSAttributedString(
                string: "Cannot be empty!",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            passwordTF.backgroundColor = .systemRed.withAlphaComponent(0.6)
            return false
        }
        guard passwordTF.text!.count > 7 else {
            passwordWarningLabel.isHidden = false
            return false
        }
        guard (loginTF.text! == "user@vk.com" && passwordTF.text! == "12345678") else {
            
            let alert = UIAlertController(title: "Incorrect login or password!", message: "\nPlease, check your login and password. Try again.\n\nDemo account: \nLogin: \"user@vk.com\"\nPassword: \"12345678\"", preferredStyle: .alert)
            
            let alertOK = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertOK)
            present(alert, animated: true)
            return false
        }
        
        return true
    }
}

// MARK: - extensions

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        login()
        return true
    }
}

