//
//  SendMessageTableViewCell.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/25/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import UIKit

class SendMessageTableViewCell: UITableViewCell {

    @IBOutlet private weak var imgvThumbnail:UIImageView!
    @IBOutlet private weak var vwSubContent:UIView!
    @IBOutlet private weak var lblMessage:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwSubContent.makeBoder(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), width: 1, cornerRadius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMessageContent(message:String) {
        self.lblMessage.text = message
    }
}
