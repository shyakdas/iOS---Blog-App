//
//  DatabaseManager.swift
//  BlogApp
//
//  Created by Shyak Das on 25/09/23.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init() {}
    
    public func insert(blogPost : BlogPost,
                               user : String,
                               completion: @escaping (Bool) -> Void)
    {
         
    }
    
    public func getAllPost(completion: @escaping ([BlogPost]) -> Void)
    {
         
    }
    
    
    public func getPosts(user : User,completion: @escaping ([BlogPost]) -> Void)
    {
         
    }
    
    public func insert(user : User, completion: @escaping (Bool) -> Void)
    {
        let docuementId = user.email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
          
        let data = ["email" : user.email,
                    "name" : user.name]
        database
            .collection("users")
            .document(docuementId)
            .setData(data) { error in
            completion(error == nil)
        }
    }
}
