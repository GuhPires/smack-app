//
//  AvatarCell.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 13/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
