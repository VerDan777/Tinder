//
//  ViewController.swift
//  Tinder
//
//  Created by We//Yes on 02/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topStackView = TopNavigationStackView();
    let cardsDeckView = UIView();
    let bottomStackView = HomeButtonStackView();
    
    let users: [User] = [
      User(name: "Kelly", age: "23", profession: "Programmer", imageNames: ["ironman"]),
      User(name: "Alexandra", age: "18", profession: "Architect", imageNames:["woman"]),
      User(name: "Sonya", age: "19", profession: "Model", imageNames: ["woman2"]),
      User(name: "Alina", age: "21", profession: "Designer", imageNames: ["woman3"])
    ];
    let cardViewsModel = [
        User(name: "Kelly", age: "23", profession: "Programmer", imageNames: ["ironman", "woman"]).toCardViewModel(),
        User(name: "Alexandra", age: "18", profession: "Architect", imageNames:["woman", "ironman"]).toCardViewModel(),
        User(name: "Sonya", age: "19", profession: "Model", imageNames: ["woman2"]).toCardViewModel(),
        User(name: "Alina", age: "21", profession: "Designer", imageNames: ["woman3"]).toCardViewModel(),
        Advertiser(title: "Hello", brandName: "It's Tinder", posterPhotoName: "poster").toCardViewModel(),
    ];

    fileprivate func setupLayouts() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView]);
        overallStackView.axis = .vertical;
        
        view.addSubview(overallStackView);
        
        overallStackView.frame = .init(x: 0, y: 0, width: 300, height: 200);
        overallStackView.isLayoutMarginsRelativeArrangement = true;
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8);
        overallStackView.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0);
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
    fileprivate func setupDummyCards() {
        cardViewsModel.forEach{ (cardVM) in
            let cardView = CardView(images: cardVM.imageNames);
            cardView.imageView.image = UIImage(named: cardVM.imageNames[0]);
            cardView.informationLabel.attributedText = cardVM.attributedString;
            cardView.informationLabel.textAlignment = cardVM.textAlignment;
            print(cardVM.imageNames.count);
            cardView.informationLabel.numberOfLines = 0;
            cardsDeckView.addSubview(cardView);
            cardView.fillSuperview();
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts();
        setupDummyCards();
    }
}

