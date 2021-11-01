//
//  SPDMyStickerChatCell.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/19.
//

import UIKit
import Stipop

class SPDMyStickerChatCell: UITableViewCell {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var stickerView: SPUIStickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 15
    }
}
