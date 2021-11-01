//
//  SPDChatroomHeaderCell.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/20.
//

import UIKit

class SPDChatroomHeaderCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let date = Date()
        let hour = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        timeLabel.text = "\(hour):\(minutes)"
    }
}
