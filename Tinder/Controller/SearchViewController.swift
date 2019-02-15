//
//  SearchViewController.swift
//  Tinder
//
//  Created by We//Yes on 07/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class CustomPickerController: UIImagePickerController {
    var imageButton: UIButton?;
}

class HeaderLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0));
    }
}

class SettingsViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imageButton1: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("Select Photo", for: .normal);
        button.backgroundColor = .white;
        button.layer.cornerRadius = 8;
        button.clipsToBounds = true;
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside);
        return button
    }();
    
    let imageButton2: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("Select Photo", for: .normal);
        button.backgroundColor = .white;
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside);
        return button
    }();
    
    let imageButton3: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("Select Photo", for: .normal);
        button.backgroundColor = .white;
        button.layer.cornerRadius = button.frame.height / 2;
        button.layer.masksToBounds = true;
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside);
        return button
    }();
    
    @objc fileprivate func handleClick(button: UIButton) {
        let imagePicker = CustomPickerController();
        imagePicker.delegate = self;
        imagePicker.imageButton = button;
        self.present(imagePicker, animated: true);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage;
        let imageButton = (picker as? CustomPickerController)?.imageButton;
        imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal);
        dismiss(animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupNavigations();
        fetchProfile();
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1);
        tableView.tableFooterView = UIView();
        tableView.keyboardDismissMode = .interactive;
//        let txt = CATextLayer();
//        txt.string = 'txt';
//        txt.foregroundColor
    }
    
    var user: User?
    
    func fetchProfile() {
        let uid = Auth.auth().currentUser?.uid ?? "4i071fZmuoamyPXtyCvRNaYIl0I2";
        let ref = Database.database().reference();
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print("callback")
            // Get user value
            guard  let dict = snapshot.value as? [String: Any] else { return };
            print(dict);
            guard let name = dict["fullName"] as? String else { return };
            print(name);
            guard let age = dict["age"] as? String else { return };
            print(age);
            guard let profession = dict["profession"] as? String else { return };
            print(profession);
            guard let imageNames = dict["imageUrl"] as? String else { return };
            var imageNamesArr: [String] = [];
            imageNamesArr.append(imageNames);
            
            self.user = User(name: name, age: age, profession: profession, imageNames: imageNamesArr);
            self.loadImage();
            
            self.tableView.reloadData();
            
        }) { (error) in
            print(error.localizedDescription)
        }
    };
    
    fileprivate func loadImage() {
        let image = self.user?.imageNames[0];
        guard let url = URL(string: image!) else {return};
        
        SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (imageData, _, _, _, _, _) in
            self.imageButton1.setImage(imageData?.withRenderingMode(.alwaysOriginal), for: .normal);
        }
    };
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let header = UIView();
            header.addSubview(imageButton1);
            
            imageButton1.anchor(top: header.topAnchor, left: header.leadingAnchor, bottom: header.bottomAnchor, right: nil, paddingTop: 16, paddingBottom: 16, paddingLeft: 16, paddingRight: 0, width: 200, height: 0);
            
            let stackView = UIStackView(arrangedSubviews: [imageButton2, imageButton3]);
            stackView.axis = .vertical;
            stackView.distribution = .fillEqually;
            stackView.spacing = 16;
            
            header.addSubview(stackView);
            
            stackView.anchor(top: header.topAnchor, left: imageButton1.trailingAnchor, bottom: header.bottomAnchor, right: header.trailingAnchor, paddingTop: 16, paddingBottom: 15, paddingLeft: 16, paddingRight: 16, width: 200, height: 0);
            return header;
        }
        
        let label = HeaderLabel();
        
        switch section {
        case 1:
            label.text = "Name"
        case 2:
            label.text = "Profession"
        case 3:
            label.text = "Age"
        case 4:
            label.text = "Bio"
        default:
            label.text = "Name"
        }
        
        return label;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300;
        }
        return 40;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;   
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 5;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomCellTableViewCell();
        cell.backgroundColor = .white
        
        switch indexPath.section {
        case 1:
            cell.textField.placeholder = "Enter Name";
            cell.textField.text = self.user?.name;
        case 2:
            cell.textField.placeholder = "Enter Profession"
            cell.textField.text = self.user?.profession
        case 3:
            cell.textField.placeholder = "age"
            if user?.age != nil {
                cell.textField.text = user?.age;
            }
        default:
            cell.textField.placeholder = "Enter Bio";
        }
        return cell;
    }
    
    @objc fileprivate func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLogout() {
        print("Logout")
    }
    
    @objc func handleSave() {
        print("Save");
    }
    
    @objc func setupNavigations() {
        navigationItem.title = "Settings";
        navigationController?.navigationBar.prefersLargeTitles = true;
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismiss));
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout)),
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        ];
    }
    
}
