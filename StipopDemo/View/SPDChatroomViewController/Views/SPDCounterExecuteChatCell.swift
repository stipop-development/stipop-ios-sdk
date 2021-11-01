//
//  SPDCounterExecuteChatCell.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/19.
//

import UIKit

class SPDCounterExecuteChatCell: UITableViewCell {
    
    @IBOutlet weak var contentButton: UIButton!
    @IBAction func onContentButtonSelected(_ sender: Any) {
        onSelectPerform?()
    }
    
    var onSelectPerform: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.layer.cornerRadius = 20
        contentButton.layer.borderColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.1058823529, alpha: 1)
        contentButton.layer.borderWidth = 1
    }
}
