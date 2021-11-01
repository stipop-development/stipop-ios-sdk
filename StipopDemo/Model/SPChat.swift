//
//  SPChat.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/07/12.
//

import UIKit
import Stipop

enum SPDChatSender {
    case me
    case counter
}

enum SPDChatModel {
    case text(SPDChatSender, String)
    case sticker(SPDChatSender, String)
    case execution(SPDChatSender, String, (()->Void))
}
