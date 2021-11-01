//
//  SPDCounterTextChatCell.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/18.
//

import UIKit

class SPDCounterTextChatCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(
            roundedRect : bubbleView.bounds,
            byRoundingCorners : [.topLeft ,.topRight, .bottomRight],
            cornerRadii : CGSize(width: 14, height: 14)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        bubbleView.layer.mask = maskLayer
    }
}
