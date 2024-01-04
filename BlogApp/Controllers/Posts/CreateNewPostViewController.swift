//
//  CreateNewPostViewController.swift
//  BlogApp
//
//  Created by Shyak Das on 25/09/23.
//

import UIKit

class CreateNewPostViewController: UITabBarController {
    
    // Title
    private let titleField : UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.autocapitalizationType = .words
        field.autocorrectionType = .yes
        field.placeholder = "Enter Title..."
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        return field
    }()
    
    // Image Header
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.image =  UIImage(systemName: "photo")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    
    // TextView for Post
    private let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 28)
        return textView
    }()
    
    private var selectHeaderImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerImageView)
        view.addSubview(textView)
        view.addSubview(titleField)
        confirgureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleField.frame = CGRect(x: 10,
                                  y: view.safeAreaInsets.top,
                                  width: view.width - 20,
                                  height: 50)
        
        headerImageView.frame = CGRect(x: 0,
                                       y: titleField.bottom+5,
                                       width: view.width,
                                       height: 160)
        textView.frame = CGRect(x: 10,
                                y: headerImageView.bottom+10,
                                width: view.width-20,
                                height: view.height-210-view.safeAreaInsets.top)
    }
    
    private func confirgureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapPost))
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPost(){
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = selectHeaderImage,
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
    }
}
