//
//  RoundedButton.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 12/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
    
}
