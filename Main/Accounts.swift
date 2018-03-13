//
//  Account.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/24.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

class Accounts: JSONDecodable {
    static var phone: String = ""
    static var password: String = ""
    
    static var userId: String = ""
    static var userName: String = ""
    static var loginType: Int = 0
    
    required init(json: JSON) throws {
        Accounts.userId = json["account"]["id"].stringValue
        Accounts.loginType = json["loginType"].intValue
        
        //print(Accounts.userId, Accounts.loginType)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

    }
}
