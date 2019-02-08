//
//  CardView.swift
//  Tinder
//
//  Created by We//Yes on 02/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import Accelerate

class CardView: UIView {
    
    var images: [String] = [];

    let imageView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "woman"));
        img.contentMode = .scaleAspectFill;
        return img;
    }();
    
    var informationLabel: UILabel = {
        let informationLabel = UILabel();
        informationLabel.text = "default";
        informationLabel.textColor = .white;
        informationLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold);
        return informationLabel;
    }();

    let gradientLayer = CAGradientLayer();
    fileprivate let barStackView = UIStackView();
    
     init(images: [String]) {
        self.images = images;
        super.init(frame: .zero);
        layer.cornerRadius = 10;
        clipsToBounds = true;
        
        addSubview(imageView);
        setupGradientLayer();
        addSubview(informationLabel);
        
        setupBarStackView();
        
        informationLabel.anchor(top: nil, left: self.leadingAnchor, bottom: bottomAnchor, right: self.trailingAnchor, paddingTop: 0, paddingBottom: 20, paddingLeft: 12, paddingRight: 0, width: 0, height: 0);
        
        imageView.fillSuperview();
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan));
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap));
        addGestureRecognizer(tapGesture);
        addGestureRecognizer(panGesture);
    }
    
    var imageIndex = 0;
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let shouldNextPhoto = gesture.location(in: nil).x > frame.width / 2 ? true : false;
        
        if shouldNextPhoto {
            imageIndex = min(imageIndex + 1, images.count - 1);
        } else {
            imageIndex = max(0, imageIndex - 1);
        }
        
        let imageName = self.images[imageIndex];
        imageView.image = UIImage(named: imageName);
        barStackView.arrangedSubviews.forEach { (v) in
            v.backgroundColor = UIColor(white: 0, alpha: 0.1);
        }
        barStackView.arrangedSubviews[imageIndex].backgroundColor = .white;
    }
    
    fileprivate func setupBarStackView() {
        addSubview(barStackView);
        barStackView.anchor(top: topAnchor, left: self.leadingAnchor, bottom: nil, right: self.trailingAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 8, paddingRight: 8, width: 0, height: 4);

        barStackView.spacing = 4;
        barStackView.distribution = .fillEqually;
        
        (0..<images.count).forEach { (view) in
            let view = UIView();
            view.backgroundColor = UIColor(white: 0, alpha: 0.1);
            barStackView.addArrangedSubview(view);
        }
        barStackView.arrangedSubviews.first?.backgroundColor = .white
    };
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor];
        gradientLayer.locations = [0.5,1.1];
        
        layer.addSublayer(gradientLayer);
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame;
    }
    
    fileprivate func handleEndAnimation(_ gesture: UIPanGestureRecognizer) {
        let shouldDismiss = gesture.translation(in: nil).x > 100 || gesture.translation(in: nil).x < -100;

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if shouldDismiss {
                self.transform = self.transform.translatedBy(x: 1000, y: 0);
                self.removeFromSuperview();
            } else {
                self.transform = .identity;
            }
        }){ (_) in
            self.transform = .identity;
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                superview?.layer.removeAllAnimations()
            })
        case .changed:
            let translation = gesture.translation(in: nil);
            let degrees: CGFloat = translation.x / 20;
            let angle = degrees * .pi / 180;
            let rotationalTransformation = CGAffineTransform(rotationAngle: angle);
            self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y);
        case .ended:
            handleEndAnimation(gesture)
        default:
            ()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error");
    }
}
