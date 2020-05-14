//
//  CircleImage.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 14/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
