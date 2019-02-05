//
//  RegisterViewController.swift
//  Tinder
//
//  Created by We//Yes on 04/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let selectButton: UIButton = {
        let selectButton = UIButton(type: .system);
        selectButton.setTitle("Select Photo", for: .normal);
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy);
        selectButton.setTitleColor(.black, for: .normal);
        selectButton.heightAnchor.constraint(equalToConstant: 300).isActive = true;
        selectButton.layer.cornerRadius = 16;
        selectButton.backgroundColor = .white;
        return selectButton;
    }();
    
    let fullNameTextField: CustomTextField = {
        let nameTf = CustomTextField();
        nameTf.placeholder = "Name";
        nameTf.backgroundColor = .white;
        nameTf.layer.cornerRadius = 16;
        return nameTf;
    }();

    let emailTextField: CustomTextField = {
        let emailTf = CustomTextField();
        emailTf.placeholder = "Name";
        emailTf.backgroundColor = .white;
        emailTf.layer.cornerRadius = 16;
        return emailTf;
    }();
    
    let passwordTextField: CustomTextField = {
        let passwordTf = CustomTextField();
        passwordTf.placeholder = "Name";
        passwordTf.backgroundColor = .white;
        passwordTf.layer.cornerRadius = 16;
        return passwordTf;
    }();
    
    let signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system);
        signUpButton.setTitle("Register", for: .normal);
        signUpButton.setTitleColor(.white, for: .normal);
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy);
        signUpButton.backgroundColor = .red;
        signUpButton.layer.cornerRadius = 16;
        
        return signUpButton;
    }();
    
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer();
        gradientLayer.locations = [0,1];
        gradientLayer.colors = [UIColor.rgb(red: 253, green: 91, blue: 95).cgColor, UIColor.rgb(red: 229, green: 0, blue: 114).cgColor];
        gradientLayer.frame = view.frame;
        self.view.layer.addSublayer(gradientLayer);
    }
    
    fileprivate func setupNofiticationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil);
    };
    
    fileprivate func setupDismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)));
    }
    
    @objc func handleTap() {
        self.view.endEditing(true);
    }
    
    @objc func handleHideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
           self.view.transform = .identity;
        })
    }
    
    @objc func handleShowKeyboard(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return };
        let keyboardFrame = value.cgRectValue;
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height;
        
        let difference = keyboardFrame.height - bottomSpace;
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 20);
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        signUpButton
        ]);

    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupGradientLayer();
        setupNofiticationObservers();
        setupDismissKeyboard();
        stackView.axis = .vertical;
        stackView.spacing = 8;
        
        self.view.addSubview(stackView);

        stackView.anchor(top: nil, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 32, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0);
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true;
    }

}
