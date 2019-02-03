//
//  CardView.swift
//  Tinder
//
//  Created by We//Yes on 02/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class CardView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        layer.cornerRadius = 10;
        clipsToBounds = true;
        
        addSubview(imageView);
        setupGradientLayer();
        addSubview(informationLabel);
        
        informationLabel.anchor(top: nil, left: self.leadingAnchor, bottom: bottomAnchor, right: self.trailingAnchor, paddingTop: 0, paddingBottom: 20, paddingLeft: 12, paddingRight: 0, width: 0, height: 0);
        
        imageView.fillSuperview();
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan));
        addGestureRecognizer(panGesture);
    }
    
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
