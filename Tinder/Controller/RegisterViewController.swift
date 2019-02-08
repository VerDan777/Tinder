//
//  RegisterViewController.swift
//  Tinder
//
//  Created by We//Yes on 04/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage;
        self.selectButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal);
        dismiss(animated: true, completion: nil);
    }
}

class RegisterViewController: UIViewController {
    
    let selectButton: UIButton = {
        let selectButton = UIButton(type: .system);
        selectButton.setTitle("Select Photo", for: .normal);
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy);
        selectButton.setTitleColor(.black, for: .normal);
        selectButton.heightAnchor.constraint(equalToConstant: 300).isActive = true;
        selectButton.widthAnchor.constraint(equalToConstant: 275).isActive = true;
        selectButton.layer.cornerRadius = 16;
        selectButton.addTarget(self, action: #selector(handlePick), for: .touchUpInside);
        selectButton.backgroundColor = .white;
        selectButton.imageView?.contentMode = .scaleAspectFill;
        selectButton.clipsToBounds = true;
        return selectButton;
    }();
    
    let fullNameTextField: CustomTextField = {
        let nameTf = CustomTextField();
        nameTf.placeholder = "Name";
        nameTf.backgroundColor = .white;
        nameTf.layer.cornerRadius = 16;
        nameTf.addTarget(self, action: #selector(handleText), for: .editingChanged);
        return nameTf;
    }();

    let emailTextField: CustomTextField = {
        let emailTf = CustomTextField();
        emailTf.placeholder = "Name";
        emailTf.backgroundColor = .white;
        emailTf.layer.cornerRadius = 16;
        emailTf.addTarget(self, action: #selector(handleText), for: .editingChanged);
        return emailTf;
    }();
    
    let passwordTextField: CustomTextField = {
        let passwordTf = CustomTextField();
        passwordTf.placeholder = "Name";
        passwordTf.backgroundColor = .white;
        passwordTf.layer.cornerRadius = 16;
        passwordTf.addTarget(self, action: #selector(handleText), for: .editingChanged);
        return passwordTf;
    }();
    
    let signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system);
        signUpButton.setTitle("Register", for: .normal);
        signUpButton.setTitleColor(.white, for: .normal);
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy);
        signUpButton.backgroundColor = .gray;
        signUpButton.isEnabled = false;
        signUpButton.addTarget(self, action: #selector(handRedirect), for: .touchUpInside);
        signUpButton.layer.cornerRadius = 16;
        
        return signUpButton;
    }();
    
    @objc func handRedirect() {
        print("test");
        self.dismiss(animated:true, completion: nil);
//        navigationController?.pushViewController(UIViewController(), animated: true);
    }
    
    let gradientLayer = CAGradientLayer();
    
    @objc func handlePick() {
        print("works");
        let picker = UIImagePickerController();
        picker.delegate = self;
        picker.allowsEditing = true;
        self.present(picker, animated: true);
    };
    
    @objc func handleText(textField: UITextField) {
        if textField == fullNameTextField {
            print("fullname")
            registrationViewModel.fullName = textField.text
        } else if textField == emailTextField {
            print("email")
            registrationViewModel.email = textField.text
        } else {
            print("password");
            registrationViewModel.password = textField.text
        }
        
    };
    
    fileprivate func setupGradientLayer() {
        gradientLayer.locations = [0,1];
        gradientLayer.colors = [UIColor.rgb(red: 253, green: 91, blue: 95).cgColor, UIColor.rgb(red: 229, green: 0, blue: 114).cgColor];
        gradientLayer.frame = view.bounds;
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
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 75);
    }
    
    lazy var overallStackview = UIStackView(arrangedSubviews: [
        selectButton,
        stackView,
        ]);
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            signUpButton
            ]);
        sv.axis = .vertical;
        sv.spacing = 8;
        sv.distribution = .fillEqually;
        return sv; 
    }();
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackview.axis = .horizontal
            selectButton.widthAnchor.constraint(equalToConstant: 275).isActive = true;
        } else {
            overallStackview.axis = .vertical;
        }
    }
    
    let registrationViewModel = RegistrationViewModel();
    
    fileprivate func setupRegistrationViewModelObserver() {
        registrationViewModel.isFormValidObserver = {(isFormValid) in
            print("", isFormValid);
            
            if isFormValid {
                self.signUpButton.backgroundColor = .red;
                self.signUpButton.isEnabled = true;
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        gradientLayer.frame = view.bounds;
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        
        navigationController?.setNavigationBarHidden(true, animated: false);
        
        setupGradientLayer();
        setupNofiticationObservers();
        setupRegistrationViewModelObserver();
        setupDismissKeyboard();
        
        overallStackview.axis = .vertical;
        overallStackview.spacing = 8;
        
        self.view.addSubview(overallStackview);

        overallStackview.anchor(top: nil, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 32, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0);
        overallStackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true;
    }

}
