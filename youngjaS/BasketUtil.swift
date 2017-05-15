//
//  BasketUtil.swift
//  youngjaS
//
//  Created by Shatra on 2017. 5. 9..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class BasketUtil {
    static var action:ActionButton!
    static var circleViewCntrl:CircleViewController!
    static var newCircleViewCntrl:NewCircleViewControl!
    
    class func setActionBtn(actionBtn:ActionButton) {
        self.action = actionBtn
    }
    class func getActionBtn() -> ActionButton {
        return self.action
    }
    
    class func setCircleViewController(circleViewCntrl:CircleViewController) {
        self.circleViewCntrl = circleViewCntrl
    }
    class func getCircleViewController() -> CircleViewController {
        return self.circleViewCntrl
    }
    
    class func setNewCircleViewController(newCircleViewCntrl:NewCircleViewControl) {
        self.newCircleViewCntrl = newCircleViewCntrl
    }
    class func getNewCircleViewController() -> NewCircleViewControl {
        return self.newCircleViewCntrl
    }
    
}
