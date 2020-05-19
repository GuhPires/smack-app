//
//  MessageCell.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 18/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        messageLbl.text = message.messageBody
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
}
