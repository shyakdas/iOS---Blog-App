//
//  IAPManager.swift
//  BlogApp
//
//  Created by Shyak Das on 25/09/23.
//

import Foundation

final class IAPManager {
     
    static let shared = IAPManager()
    
    private init() {}
    
    public func isPremium() -> Bool {
        return UserDefaults.standard.bool(forKey: "premium")
    }
    
    public func getSubscriptionStatus(completion : ((Bool) -> Void)?) {
        UserDefaults.standard.set(true, forKey: "premium")
        completion?(true)
    }
    
    public func subscribe(completion : @escaping (Bool) -> Void) {
        UserDefaults.standard.set(true, forKey: "premium")
        completion(true)
    }
    
    public func restorePurchases(completion : @escaping (Bool) -> Void) {
        UserDefaults.standard.set(true, forKey: "premium")
        completion(true)
    }
}
 
