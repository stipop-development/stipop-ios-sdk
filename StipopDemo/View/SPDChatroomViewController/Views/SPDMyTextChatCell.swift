//
//  SPDMyTextChatCell.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/19.
//

import UIKit

class SPDMyTextChatCell: UITableViewCell {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        bubbleView.layer.cornerRadius = 15
//        bubbleView.clipsToBounds = true
    }
    
    let gradient = CAGradientLayer()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [
            #colorLiteral(red: 1, green: 0.3058823529, blue: 0.07058823529, alpha: 1).cgColor,
            #colorLiteral(red: 1, green: 0.4392156863, blue: 0.1176470588, alpha: 1).cgColor
        ]
        gradient.frame = bubbleView.bounds
        bubbleView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(
            roundedRect : bubbleView.bounds,
            byRoundingCorners : [.topLeft ,.topRight, .bottomLeft],
            cornerRadii : CGSize(width: 15, height: 15)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        bubbleView.layer.mask = maskLayer
        gradient.frame = bubbleView.bounds
    }
}
