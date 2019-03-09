//
//  UserDetailController.swift
//  Tinder
//
//  Created by We//Yes on 09/03/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import JGProgressHUD

class UserDetailController: UIViewController, UIScrollViewDelegate {
    
    let swpViewController = SwipingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal);
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.show(in: UIView());
        hud.textLabel.text = "Loading...";
        return hud;
    }();
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system);
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal);
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside);
        button.contentMode = .scaleAspectFit;
        return button;
    }();
    
    var cardViewModel: CardViewModel? {
        didSet {
            self.infoLabel.attributedText = cardViewModel?.attributedString;

            self.swpViewController.stackCards = cardViewModel;
        }
    };
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView();
        sv.alwaysBounceVertical = true;
        sv.delegate = self;
        sv.contentInsetAdjustmentBehavior = .never
        return sv;
    }();
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y;
        let imageView = swpViewController.view!;
        imageView.frame = CGRect(x: min(0,-changeY), y: min(0, -changeY), width: self.view.frame.width + changeY * 2, height: self.view.frame.width + changeY * 2)
        print(changeY);
    }
    
    func setupBlur() {
        let blur = UIBlurEffect(style: .regular);
        let visualEffectView = UIVisualEffectView(effect: blur);
        self.view.addSubview(visualEffectView);
        visualEffectView.anchor(top: self.view.topAnchor, left: self.view.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0);
//        self.visualEffectView.fillSuperview();
    };
    
    
    lazy var disslikeButton = self.createButton(image: UIImage(named: "dismiss_circle")!, selector: #selector(dismissHandle));
    lazy var superLikeButton = self.createButton(image: UIImage(named: "super_like")!, selector: #selector(supekLikeHandle));
    lazy var likeButton = self.createButton(image: UIImage(named: "like")!, selector: #selector(handleSuperLike));
    
    @objc func dismissHandle() {
        
    }
    
    @objc func supekLikeHandle() {
        
    };
    
    @objc func handleSuperLike() {
        
    };
    
    func createButton(image: UIImage, selector: Selector) -> UIButton {
        let button = UIButton(type: .system);
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal);
        return button;
    };
    
    func setupBottomButtons() {
        let sv = UIStackView(arrangedSubviews: [disslikeButton, superLikeButton, likeButton]);
        sv.axis = .horizontal;
        sv.distribution = .fillEqually
        
        self.view.addSubview(sv);
        sv.anchor(top: nil, left: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 300, height: 80);
        sv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
    };
    
    let barStackView = UIStackView(arrangedSubviews: []);
    
    fileprivate func setupBars() {
        self.cardViewModel?.imageNames.forEach({ (bar) in
            let barView = UIView();
            barView.backgroundColor = .white;
            barView.layer.cornerRadius = 2;
            barStackView.addArrangedSubview(barView);
        });
        
        barStackView.arrangedSubviews.first?.backgroundColor = .gray;
        
        barStackView.distribution = .fillEqually;
        barStackView.axis = .horizontal;
        barStackView.spacing = 4;
        self.view.addSubview(barStackView);
        self.barStackView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, bottom: nil, right: self.view.trailingAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 4, paddingRight: 4, width: 0, height: 4);
    }
    
//    let imageView: UIImageView = {
//        let image = UIImageView(image: UIImage(named: "woman"));
//        image.contentMode = .scaleAspectFill;
//        image.clipsToBounds = true;
//        return image;
//    }();

    let infoLabel: UILabel = {
        let label = UILabel();
        label.text = "Some text by /n userName";
        label.textColor = .black;
        label.numberOfLines = 0;
        return label;
    }();
    
    @objc func handleDismiss() {
        
    }
    
    @objc func handlePan(gesture: UITapGestureRecognizer) {
        print(gesture);
        self.dismiss(animated: true, completion: nil);
        
    };
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        let imageView = swpViewController.view!;
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .white;
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handlePan));
        self.view.addGestureRecognizer(gesture);
        
        self.view.addSubview(scrollView);
        
        
        let imageView = swpViewController.view!
        scrollView.addSubview(imageView);
        scrollView.addSubview(infoLabel);
        scrollView.addSubview(dismissButton);
        
        setupBottomButtons();
        
        scrollView.fillSuperview();
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width);
        infoLabel.anchor(top: imageView.bottomAnchor, left: scrollView.leadingAnchor, bottom: nil, right: scrollView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0);
        dismissButton.anchor(top: nil, left: nil, bottom: imageView.bottomAnchor, right: imageView.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 0, paddingRight: 12, width: 50, height: 50);
        
        setupBars();
        
        setupBlur();
//        imageView.anchor(top: self.scrollView.topAnchor, left: self.scrollView.leadingAnchor, bottom: self.scrollView.bottomAnchor, right: self.scrollView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0);
        // Do any additional setup after loading the view.
    };
    
}
