//
//  User.swift
//  Tinder
//
//  Created by We//Yes on 03/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

struct User:ProducesCardViewModel {
    let name: String;
    let age: String;
    let profession: String;
    let imageName: String;
    
    init(name: String, age: String, profession: String, imageName: String) {
        self.name = name;
        self.age = age;
        self.profession = profession;
        self.imageName = imageName;
    }
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)]);
        
        attributedText.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]));
        attributedText.append(NSAttributedString(string: "\n \(profession)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]));
        return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
    
}
