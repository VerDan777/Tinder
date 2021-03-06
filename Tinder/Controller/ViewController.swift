//
//  ViewController.swift
//  Tinder
//
//  Created by We//Yes on 02/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

struct TestUser {
    var fullName: String
    var imageUrl: String
    var uid: String
    
    init(dict: [String:Any]) {
        self.fullName = dict["fullName"] as? String ?? "";
        self.imageUrl = dict["imageUrl"] as? String ?? "";
        self.uid = dict["uid"] as? String ?? "";
    }
}

class ViewController: UIViewController, UserDetailDelegate {
    
    let topStackView = TopNavigationStackView();
    let cardsDeckView = UIView();
    let bottomStackView = HomeButtonStackView();
    
    var count: Int = 0;

    let users: [User] = [
      User(name: "Kelly", age: "23", profession: "Programmer", imageNames: ["ironman"]),
      User(name: "Alexandra", age: "18", profession: "Architect", imageNames:["woman"]),
      User(name: "Sonya", age: "19", profession: "Model", imageNames: ["woman2"]),
      User(name: "Alina", age: "21", profession: "Designer", imageNames: ["woman3"])
    ];
    
    var cardViewsModel = [CardViewModel]();

    @objc func hanleGoSettings() {
        let settings = SettingsViewController();
        let navContoller = UINavigationController(rootViewController: settings);
        self.present(navContoller, animated: true);
    };
    
    fileprivate func setupLayouts() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView]);
        overallStackView.axis = .vertical;
        
        view.addSubview(overallStackView);
        
        topStackView.settingsButton.addTarget(self, action: #selector(hanleGoSettings), for: .touchUpInside);
        
        overallStackView.frame = .init(x: 0, y: 0, width: 300, height: 200);
        overallStackView.isLayoutMarginsRelativeArrangement = true;
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8);
        overallStackView.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0);
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
//        if Auth.auth().currentUser == nil {
//            let registrationViewController = RegisterViewController();
//            let navController = UINavigationController(rootViewController: registrationViewController);
//            self.present(navController, animated: true);
//        };
    };
    
    
    func handleTapMoreInfo(card cardViewModel: CardViewModel) {
        count = count + 1;
        print("You tap \(count), \(cardViewModel)")
        
        let userDetailController = UserDetailController();
        userDetailController.cardViewModel = cardViewModel;
        self.present(userDetailController, animated: true);
    }
    
    let hud = JGProgressHUD(style: .dark);
    
    fileprivate func fetchData() {
        hud.show(in: view);
        hud.textLabel.text = "Loading...";
        let ref = Database.database().reference();
        ref.child("users").observe(DataEventType.value) { (snapshot, err) in
            if let err = err {
                print(err);
                return
            }
//            print(snapshot);
            guard let dict = snapshot.value as? [String: Any] else { return };
            
            for (_, value) in dict {
                guard let cast = value as? [String: Any] else {
                    print("failed cast")
                    return
                };
                guard let fullName = cast["fullName"] as? String else {
                    print("failed fullName")
                    return
                };
                guard let urlOfImage = cast["urls"] as? [String] else {
                    print("failed imageUrl")
                    return
                    
                };
                guard let profession = cast["profession"] as? String else {
                    print("failed profession")
                    return
                };
                guard let age = cast["age"] as? String else {
                    print("age failed")
                    return
                };
                
                let infoUser = User(name: fullName, age: age, profession: profession, imageNames: urlOfImage)
                self.cardViewsModel.append(infoUser.self.toCardViewModel());
                self.hud.dismiss();
                self.setupDummyCards();
            }
            
        }
    };
    
    fileprivate func setupDummyCards() {
        cardViewsModel.forEach{ (cardVM) in
            let cardView = CardView(images: cardVM.imageNames);
            downLoad(url: cardVM.imageNames[0]) { (data) in
                DispatchQueue.main.async {
                    cardView.imageView.image = UIImage(data: data);
                }
            }	
            cardView.informationLabel.attributedText = cardVM.attributedString;
            cardView.informationLabel.textAlignment = cardVM.textAlignment;
            cardView.card = cardVM;
            print(cardVM.imageNames.count);
            cardView.delegate = self;
            cardView.informationLabel.numberOfLines = 0;
            cardsDeckView.addSubview(cardView);
            cardView.fillSuperview();
        }
    };
    
    func downLoad(url: String, completition: @escaping (Data) -> ()) {
        hud.textLabel.text = "Fetching user photo";
        hud.show(in: view);
        let request = URL(string: url)!;
        
        URLSession.shared.dataTask(with: URLRequest(url: request)) { (data, res, err) in
            if let err = err {
                print(err);
//                completition(err);
            }
            guard let data = data else { return };
            self.hud.dismiss();
                completition(data);
            }.resume();
    };
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        navigationController?.isNavigationBarHidden = true;

        view.backgroundColor = .white;
        
        fetchData();
        setupLayouts();
    }
}

