//
//  TwitterUtils.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/26/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import Foundation
import TwitterKit
import AESCrypt_ObjC

class TwitterUtils {
    static let share = TwitterUtils()
    
    private init () {}
    
    var userId:String? = {
        return UserDefaults.standard.value(forKey: "TwitterUserId") as? String
    }()
    
    func register() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: "eq1tJWftjQ3cmVllxg0AyK368", consumerSecret: key())
    }
    
    func sendTweet(message:String, completion:@escaping (TWTRTweet?, Error?) -> Void) {
        let client = TWTRAPIClient(userID: userId)
        
        client.sendTweet(withText: message) { (tweet:TWTRTweet?, error:Error?) in
            completion(tweet, error)
        }
    }
    
    func login(completion:@escaping ((TWTRSession?, Error?) -> Void)) {
        TWTRTwitter.sharedInstance().logIn { [weak self](session, error) in
            if let userId = session?.userID {
                UserDefaults.standard.set(userId, forKey: "TwitterUserId")
                self?.userId = userId
            }
            completion(session, error)
        }
    }
    
    func isLogined() -> Bool {
        return TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }
    
    private func key() -> String {
        let string = "PjDhcVxawJX7tZPl/W59fBd3t87PfUSDMWopM5/1SWpc7oI4/mikU5+giRDANbCsX+R5256xxQTzpbYEXUYOuw=="
        return AESCrypt.decrypt(string, password: "key")
    }
}
