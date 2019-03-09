//
//  LoginViewController.swift
//  Tinder
//
//  Created by We//Yes on 09/03/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import JGProgressHUD

class LoginViewController: UIViewController {

    let emailTextField: CustomTextField = {
        let emailTf = CustomTextField();
        emailTf.placeholder = "email";
        emailTf.backgroundColor = .white;
        emailTf.layer.cornerRadius = 16;
//        emailTf.addTarget(self, action: #selector(handleText), for: .editingChanged);
        return emailTf;
    }();
    
    let passwordTextField: CustomTextField = {
        let passwordTf = CustomTextField();
        passwordTf.placeholder = "password";
        passwordTf.isSecureTextEntry = true;
        passwordTf.backgroundColor = .white;
        passwordTf.layer.cornerRadius = 16;
//        passwordTf.addTarget(self, action: #selector(handleText), for: .editingChanged);
        return passwordTf;
    }();
    
    let signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system);
        signUpButton.setTitle("Login", for: .normal);
        signUpButton.setTitleColor(.white, for: .normal);
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy);
        signUpButton.backgroundColor = .gray;
        signUpButton.isEnabled = true;
        signUpButton.addTarget(self, action: #selector(handleRedirect), for: .touchUpInside);
        signUpButton.layer.cornerRadius = 16;
        
        return signUpButton;
    }();
    
    @objc func handleRedirect() {
        let spinner = JGProgressHUD(style: .dark);
        spinner.textLabel.text = "Loading..."
        spinner.dismiss(afterDelay: 3.0, animated: true)
        spinner.show(in: view);
    }
    

    let registrationViewModel = RegistrationViewModel();
    
    @objc func handleText(textField: UITextField) {
        if textField == emailTextField {
            print("email")
            registrationViewModel.email = textField.text
        } else {
            print("password");
            registrationViewModel.password = textField.text
        }
        
    };
    
    @objc func handleTap() {
        self.view.endEditing(true);
    }
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            signUpButton,
            ]);
        sv.axis = .vertical;
        sv.spacing = 8;
        sv.distribution = .fillEqually;
        return sv;
    }();
    
//    lazy var overallStackview = UIStackView(arrangedSubviews: [
//        stackView,
//        ]);

    func setupGradient() {
        let gradientLayer = CAGradientLayer();
        gradientLayer.frame =  view.frame;
        gradientLayer.colors = [UIColor.rgb(red: 253, green: 91, blue: 95).cgColor, UIColor.rgb(red: 229, green: 0, blue: 114).cgColor];
        gradientLayer.frame = view.bounds;
        self.view.layer.addSublayer(gradientLayer);
    };
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupGradient();
        
        navigationController?.isNavigationBarHidden = false;
        
        stackView.axis = .vertical;
        stackView.spacing = 8;
        
        self.view.addSubview(stackView);

        stackView.anchor(top: nil, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 32, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0);

        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true;
    }

}
