//
//  HomeButtonStackViiew.swift
//  Tinder
//
//  Created by We//Yes on 02/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit

class HomeButtonStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true;
        let subViews = [#imageLiteral(resourceName: "refresh"),#imageLiteral(resourceName: "reject"), #imageLiteral(resourceName: "favorite"), #imageLiteral(resourceName: "like"), #imageLiteral(resourceName: "energy")].map { (img) -> UIView in
            let button = UIButton(type: .system);
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal);
            return button
        }
        
        subViews.forEach { (v) in
            addArrangedSubview(v);
        }
        
        
        distribution = .fillEqually;
    }

    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented");
    }
}
