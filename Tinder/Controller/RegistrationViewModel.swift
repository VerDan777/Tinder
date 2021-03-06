//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by We//Yes on 05/02/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false;
        isFormValidObserver?(isFormValid);
    }
    
    var isFormValidObserver: ((Bool) -> ())?
}
