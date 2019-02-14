//
//  CustomCellTableViewCell.swift
//  Tinder
//
//  Created by We//Yes on 14/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class TableTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0);
    }
};

class CustomCellTableViewCell: UITableViewCell {
    
    let textField: TableTextField = {
        let tf = TableTextField();
        tf.placeholder = "Enter text...";
        return tf;
    }();
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        addSubview(textField);
        textField.anchor(top: self.superview?.topAnchor, left: self.superview?.leadingAnchor, bottom: self.superview?.bottomAnchor, right: self.superview?.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
