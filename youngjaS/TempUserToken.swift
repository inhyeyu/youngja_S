//
//  TempUserToken.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 30..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire


final class TempUserToken {
    
    static let instance = TempUserToken()
    
    let response: Result<String>? = nil
    var tk:String = ""
    
    func sessions() -> String {
        var token:String = ""
        let userInfo = ["username":"inhye.yu@bankwareglobal.com", "password": "efb0d283f0b2518c1547b21041f1a31c30050576fe6bfb1530f3a62670035727"]
        
        let loginRequest: DataRequest = Alamofire.request("https://stage-api.moimdomo.com/sessions", method: .post, parameters: userInfo, encoding: JSONEncoding.default)
        
        let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
            if let body = result.value {
                print("## result.value >> " + "\(body)")
                //self.tk = body
                token = body
            }
        }
        
        loginRequest.responseString { response in
            requestComplete(response.response, response.result)
        }
        return token
    }
}
