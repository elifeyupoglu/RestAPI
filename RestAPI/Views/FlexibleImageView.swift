//
//  FlexibleImageView.swift
//  RestAPI
//
//  Created by Elif on 19.01.2020.
//  Copyright © 2020 Elif. All rights reserved.
//

import UIKit

@IBDesignable
class FlexibleImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        willSet {
            layer.cornerRadius = newValue
        }
    }
    
}
