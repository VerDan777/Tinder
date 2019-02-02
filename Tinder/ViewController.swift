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
        let cardView = CardView(frame: .zero);
        cardsDeckView.addSubview(cardView);
        cardView.fillSuperview();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts();
        setupDummyCards();
    }
}

