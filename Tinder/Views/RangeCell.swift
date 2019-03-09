//
//  RangeCell.swift
//  Tinder
//
//  Created by We//Yes on 18/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class RangeCell: UITableViewCell {
//    let minSLider: UISlider = {
//
//        return sl;
//    }();
    
    func createSlider() -> UISlider {
        let s = UISlider();
        s.minimumValue = 10;
        return s;
    };
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        let slider = createSlider();
        self.addSubview(slider);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
