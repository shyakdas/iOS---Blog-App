//
//  StorageManager.swift
//  BlogApp
//
//  Created by Shyak Das on 25/09/23.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let container = Storage.storage().reference()
    
    private init() {}
    
    public func uploadUserProfilePicture(email : String,
                                         image : UIImage?,
                                         completion :@escaping (Bool) -> Void) {
        
        
    }
    
    public func downloadUrlForProfilePicture(user : User,
                                             completion : @escaping (URL?) -> Void) {
        
    }
    
    public func uploadBlogHeaderImage(blogPost : BlogPost,
                                      image : UIImage?,
                                      completion :@escaping (Bool) -> Void) {
        
        
    }
    
    public func donwloadUrlForPostHeader(blogPost : BlogPost,
                                         completion : @escaping (URL?) -> Void) {
         
    }
}
