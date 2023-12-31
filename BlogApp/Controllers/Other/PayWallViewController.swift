//
//  PayWallViewController.swift
//  BlogApp
//
//  Created by Shyak Das on 27/09/23.
//

import UIKit

class PayWallViewController: UIViewController {
    
    private let header = PayWallHeaderView()
    private let heroView = PayWallDescriptionView()

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
        button.setTitle("Restore Purchases", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    // Terms and Service
    private let termsView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize : 14)
        textView.textColor = .secondaryLabel
        textView.text = "This is an auto-renewable Subsription. It will be charged to your iTunes account before each pay period. You can cancel anytime by going into your Settings > Subscribtions. Restore purchaces if previously subscribed"
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blog App Premium"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        view.addSubview(buyButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
        view.addSubview(heroView)
        setUpCloseButton()
        setUpButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame =  CGRect(x: 0,
                               y: view.safeAreaInsets.top,
                               width: view.width,
                               height: view.height / 3.2)
        
        termsView.frame =  CGRect(x: 10,
                                  y: view.height - 100,
                                  width: view.width - 20,
                                  height: 100)
        
        restoreButton.frame =  CGRect(x: 25,
                                      y: termsView.top - 70,
                                      width: view.width - 50,
                                      height: 50)
        
        buyButton.frame =  CGRect(x: 25,
                                  y: restoreButton.top - 60,
                                  width: view.width - 50,
                                  height: 50)
        
        
        heroView.frame =  CGRect(x: 0,
                                 y: header.bottom,
                                  width: view.width,
                                 height: buyButton.top - view.safeAreaInsets.top - header.height)
          
    }
    
    private func setUpButton() {
        buyButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }
     
    @objc private func didTapSubscribe() {
        IAPManager.shared.subscribe() { [weak self] success in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func didTapRestore() {
        IAPManager.shared.restorePurchases() { [weak self] success in
            self?.dismiss(animated: true, completion: nil)
        }
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
