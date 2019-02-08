//
//  TopNavigationStackView.swift
//  Tinder
//
//  Created by We//Yes on 02/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    @objc func handleTap() {
        let settings = SettingsViewController();
//        navigation present(settings, animated: true);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        
        let subViews = [#imageLiteral(resourceName: "person"), #imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "chat")].map { (img) -> UIView in
            let button = UIButton(type: .system);
            button.addTarget(self, action: #selector(handleTap), for: .touchUpInside);
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal);
            return button;
        }
        
        subViews.forEach{ (view) in
            addArrangedSubview(view);
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true;
        
        layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12);
    }
    
    required init(coder: NSCoder) {
        fatalError("fatal error");
    }

}
