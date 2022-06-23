//
//  SPDMainViewController.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/12.
//

import UIKit
import Stipop

class SPDMainViewController: UIViewController {
    
    @IBAction func goToDemoAppButton(_ sender: Any) {
        guard let url = URL(string: "https://docs.stipop.io/en/sdk/ios/get-started/before-you-begin") else { return }
        UIApplication.shared.open(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func newUserLoginClicked(_ sender: Any) {
        
        let userID = UUID().uuidString
        
        self.goToChatRoomVC(user: SPUser(userID: userID))
    }
    @IBAction func commonUserLoginClicked(_ sender: Any) {
        
        // userID must not include spacing
        let userID = "someone_user_id"
        
        self.goToChatRoomVC(user: SPUser(userID: userID))
    }
    private func goToChatRoomVC(user: SPUser){
        
        let storyboard: UIStoryboard? = UIStoryboard(name: "SPDChatroomViewController", bundle: nil)
        guard let chatRoomVC = storyboard?.instantiateViewController(identifier: "SPDChatroomViewController") as? SPDChatroomViewController else { return }
        
        chatRoomVC.user = user
        
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
}
