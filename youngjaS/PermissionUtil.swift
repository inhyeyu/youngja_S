//
//  PermissionUtil.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 19..
//  Copyright © 2017년 BWG. All rights reserved.
//

import Foundation
import Alamofire

class PermissionUtil {
    
    class func isMyArticle(memberUserId:String, articleWriterId:String) -> Bool {
        return memberUserId == articleWriterId
    }
    
    class func isMaster(role:String) -> Bool {
        return role == "MASTER"
    }
    
    class func isMasterAndSecretary(role:String) -> Bool {
        return role == "MASTER_SECRETARY"
    }
    
    class func isSecretary(role:String) -> Bool {
        return role == "SECRETARY"
    }
    
    class func isMasterAuthoriry(role:String) -> Bool {
        return role == "MASTER" || role == "MASTER_SECRETARY"
    }
    
    class func isSecretaryAuthority(role:String) -> Bool {
        return role == "SECRETARY" || role == "MASTER_SECRETARY"
    }
    
    /*
    class func getMemberRole(circleId:String, token:String) -> String {
        var role = ""
        let headers:HTTPHeaders = ["Accept":"application/json"
            , "Content-Type":"application/json"
            , "x-auth-token": "\(token)"
            , "redirect": "follow"
            , "follow": "3"
            , "timeout": "10000"
            , "compress": "true"
            , "size": "0"
            , "body": "null"
            , "agent": "null"]
        
        Alamofire.request(Constant.Host.apiServer + "/circles/" + circleId + "/members"
            , method: .get
            , encoding: JSONEncoding.default
            , headers: headers).responseObject{(response: DataResponse<CircleMemberRole>) in
                
                let roleRes = response.result.value
                
                if let resultRole = roleRes?.role {
                    role = resultRole
                }
                
        }
        NotificationCenter.default.post(name: memberRoleReadyNotification, object: self)
        
        return role
    }
 */
}
