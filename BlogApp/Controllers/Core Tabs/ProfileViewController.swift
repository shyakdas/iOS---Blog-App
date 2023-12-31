//
//  ProfileViewController.swift
//  BlogApp
//
//  Created by Shyak Das on 25/09/23.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    // Profile photo
    
    // Full name
    
    // Email
    
    // List of posts
    
    private var user : User?
    
    private let tableView : UITableView = {
       let tabletView = UITableView()
        tabletView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tabletView
    }()
    
    let currentEmail : String
    
    init(currentEmail : String) {
        self.currentEmail = currentEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder) {
       fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSignOutButton()
        setUpTable()
        title = "Profile"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    private func setUpTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableHeader()
        fetchProfileData()
    }
    
    private func setUpTableHeader(profilePhotoRef : String? = nil, name : String? = nil) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        headerView.backgroundColor = .systemBlue
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        tableView.tableHeaderView = headerView
        
        
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
        profilePhoto.tintColor = .white
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(x: (view.width - (view.width/4))/2,
                                    y: (headerView.height - (view.width/4))/2.5,
                                    width: view.width/4,
                                    height: view.width/4)
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.width/2
        profilePhoto.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePhoto))
        profilePhoto.addGestureRecognizer(tap)
        headerView.addSubview(profilePhoto)
        
        // Email
        let emailLabel = UILabel(frame: CGRect(x: 20, y: profilePhoto.bottom+10, width: view.width-40, height: 100))
        headerView.addSubview(emailLabel)
        emailLabel.text = currentEmail
        emailLabel.textAlignment = .center
        emailLabel.textColor = .white
        emailLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        if let name = name {
            title = name
        }
        
        if let ref = profilePhotoRef{
            // Fetch image
            StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in
                guard let url = url else {
                    return
                }
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        profilePhoto.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
        }
    }
    
    @objc private func didTapProfilePhoto() {
        guard let myEmail = UserDefaults.standard.string(forKey: "email") ,
        myEmail == currentEmail else {
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func fetchProfileData(){
        DatabaseManager.shared.getUser(email: currentEmail) { [weak self] user in
            guard let user = user else {
                return
            }
            self?.user = user
            DispatchQueue.main.async {
                self?.setUpTableHeader(
                    profilePhotoRef: user.profilePictureReference,
                    name: user.name)
            }
        }
    }
    
    private func setUpSignOutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSignOut))
    }
    
    // Sign out
    @objc private func didTapSignOut() {
        let sheet = UIAlertController(title: "Sign Out", message: "Are you sure you'd like to sign out ?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "SignOut", style: .destructive, handler: { _ in
            AuthManager.shared.signOut() { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        let signInVc = SignInViewController()
                        signInVc.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVc = UINavigationController(rootViewController: signInVc)
                        navVc.navigationBar.prefersLargeTitles = true
                        navVc.modalPresentationStyle = .fullScreen
                        self?.present(navVc, animated: true, completion: nil)
                    }
                }
            }
        }))
        present(sheet, animated: true)
    }
    
    // Table View
    private var posts : [BlogPost] = []
    
    private func fetchPosts(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Blog post goes here!"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ViewPostViewController()
        vc.title = posts[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
                return
        }
        
        StorageManager.shared.uploadUserProfilePicture(email: currentEmail, image: image)  { [weak self] success in
            guard let strongSelf = self else { return }
            if success {
                // Update Database
                DatabaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in
                    guard updated else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.fetchProfileData()
                    }
                }
            }
        }
    }
}
