//
//  MainUIToolbar.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 22..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class SubUIToolbar: UIToolbar {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let mainToolBar:UIToolbar = self
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.plain, target: self, action: nil)
        menuBtn.tintColor = UIColor.white
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let noticeBtn = UIBarButtonItem(image: UIImage(named: "setting"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainUIToolbar.noticeButtonItemClicked))
        
        //let noticeBtn = UIBarButtonItem(image: UIImage(named: "bell"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.apple)
        
        noticeBtn.tintColor = UIColor.white
        
        
        let btns:[UIBarButtonItem] = [menuBtn, spaceBtn, noticeBtn]
        
        mainToolBar.setItems(btns, animated: true)
    }

    
    func noticeButtonItemClicked() {
        let rootViewController:UIViewController = (self.window?.rootViewController)!
        
        if let resultController = rootViewController.storyboard!.instantiateViewController(withIdentifier: "NoticeNaviController") as? UINavigationController {
        
            let trasition = CATransition()
            trasition.duration = 0.3
            trasition.type = kCATransitionPush
            trasition.subtype = kCATransitionFromRight
            rootViewController.view.window?.layer.add(trasition, forKey: kCATransition)
            
            
            rootViewController.present(resultController, animated: false, completion: nil)
        }
    }

}
