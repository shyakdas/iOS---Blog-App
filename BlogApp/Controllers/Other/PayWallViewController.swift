//
//  PayWallViewController.swift
//  BlogApp
//
//  Created by Shyak Das on 27/09/23.
//

import UIKit

class PayWallViewController: UIViewController {
    
    private let header = PayWallHeaderView()

    // Pricing and product info
    // CTA Buisness
    private let buyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let restoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    // Terms and Service

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blog App Premium"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        setUpCloseButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame =  CGRect(x: 0,
                               y: view.safeAreaInsets.top,
                               width: view.width,
                               height: view.height / 3.2)
    }
    
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(didTapClose))
        
        
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
