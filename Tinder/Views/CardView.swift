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
        let img = UIImageView(image: #imageLiteral(resourceName: "ironman").withRenderingMode(.alwaysOriginal));
        return img;
    }();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        layer.cornerRadius = 10;
        clipsToBounds = true;
        
        addSubview(imageView);
        imageView.fillSuperview();
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan));
        addGestureRecognizer(panGesture);
    }
    
    fileprivate func handleEndAnimation() {
        let shouldDismiss = false;
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if shouldDismiss {
                self.transform = self.transform.translatedBy(x: 10000, y: 0);
            } else {
                self.transform = .identity;
            }
        }){ (_) in
            self.transform = .identity;
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: nil);
            let degrees: CGFloat = translation.x / 20;
            let angle = degrees * .pi / 180;
            let rotationalTransformation = CGAffineTransform(rotationAngle: angle);
            self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y);
//            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y);
        case .ended:
            handleEndAnimation()
        default:
            ()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error");
    }
}
