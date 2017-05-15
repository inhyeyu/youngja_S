//
//  MainUIToolbar.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 22..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import CryptoSwift

class MainUIToolbar: UIToolbar {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        let mainToolBar:UIToolbar = self
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu-fat"), style: UIBarButtonItemStyle.plain, target: self, action: nil)
        menuBtn.tintColor = UIColor.white
        
        
        let mofinOreo = UIBarButtonItem(image: UIImage(named: "mofin-oreo"), style: UIBarButtonItemStyle.plain, target: self, action: nil)
        mofinOreo.tintColor = UIColor.white
        // mofinOreo.isEnabled = false
        
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let noticeBtn = UIBarButtonItem(image: UIImage(named: "bell"), style: UIBarButtonItemStyle.plain, target: self, action: nil/*#selector(MainUIToolbar.noticeButtonItemClicked)*/)
        noticeBtn.tintColor = UIColor.white
        
        // let noticeBtn = UIBarButtonItem(image: UIImage(named: "bell"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.apple)
        
        let btns:[UIBarButtonItem] = [menuBtn, mofinOreo, spaceBtn, noticeBtn]
        
        mainToolBar.setItems(btns, animated: true)
        
        // encryptTest()
        // var tt:TempUserToken = TempUserToken.instance
        
    }

    
    func noticeButtonItemClicked() {
        //let rootViewController:UIViewController = (self.window?.rootViewController)!
        
        let rootViewController:UIViewController = topViewController()!
        
        if let resultController = rootViewController.storyboard!.instantiateViewController(withIdentifier: "NoticeNaviController") as? UINavigationController {
        
            let trasition = CATransition()
            trasition.duration = 0.3
            trasition.type = kCATransitionPush
            trasition.subtype = kCATransitionFromRight
            rootViewController.view.window?.layer.add(trasition, forKey: kCATransition)
            
            
            rootViewController.present(resultController, animated: false, completion: nil)
        }
    }
    
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

}
