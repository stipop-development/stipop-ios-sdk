//
//  SPDMainViewController.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/12.
//

import UIKit

class SPDMainViewController: UIViewController {
    
    @IBAction func goToDemoAppButton(_ sender: Any) {
        guard let url = URL(string: "https://docs.stipop.io/en/sdk/ios/get-started/quick-start") else { return }
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
}
