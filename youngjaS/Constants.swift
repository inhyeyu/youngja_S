//
//  youngjaConst.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 23..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire

class Constant: NSObject {
    
    struct ColorConst {
        
        static let mainColor: UIColor = UIColor.orange
        
        // GLOBLE COLOR DEFINE
        
        static let kColor_Seperator: UIColor = UIColor(red: 53.0/255.0, green: 126.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
        static let kColor_orange: UIColor = UIColor(red: 255.0/255.0, green: 147.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        
        static let kColor_NonCompliant: UIColor = UIColor(red: 190.0/255.0, green: 15.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        
        static let kColor_Compliant: UIColor = UIColor(red: 87.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)

    }
    
    
    struct Host {
        static let apiServer: String = "https://stage-api.moimdomo.com"
    }
    
}
