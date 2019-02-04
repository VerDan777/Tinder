//
//  CustomTextField.swift
//  Tinder
//
//  Created by We//Yes on 04/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0);
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50);
    }
    
}
