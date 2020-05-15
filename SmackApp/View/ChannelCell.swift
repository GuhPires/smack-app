//
//  ChannelCell.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 15/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        channelName.text = "#\(channel.name ?? "")"
    }
}
