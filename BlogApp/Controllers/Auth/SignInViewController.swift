//
//  SignInViewController.swift
//  BlogApp
//
//  Created by Shyak Das on 25/09/23.
//

import UIKit

class SignInViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if !IAPManager.shared.isPremium() {
                let vc = PayWallViewController()
                let navVc = UINavigationController(rootViewController: vc)
                self.present(navVc, animated: true, completion: nil)
            }
        }
    }
}
