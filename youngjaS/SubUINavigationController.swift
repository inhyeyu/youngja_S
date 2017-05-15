//
//  SubUINavigationController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 12..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class SubUINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationBar.topItem?.titleView = UIImageView(image: UIImage(named: "mofin-orange"))
        
        let settingBtn = UIBarButtonItem(image: UIImage(named: "setting"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubUINavigationController.settingBtnItemClicked))
        settingBtn.tintColor = UIColor.orange
        
        let rightBarBtns:[UIBarButtonItem] = [settingBtn]
        self.navigationBar.topItem?.rightBarButtonItems = rightBarBtns
        
        //self.navigationBar.backgroundColor = UIColor.orange
        self.navigationBar.tintColor = UIColor.orange
        
    
        self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubUINavigationController.doneBtnClicked))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func doneBtnClicked() {
        let rootViewController:UIViewController = topViewController()!
        
        if let resultController = rootViewController.storyboard!.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            
            let trasition = CATransition()
            trasition.duration = 0.3
            trasition.type = kCATransitionPush
            trasition.subtype = kCATransitionFromLeft
            rootViewController.view.window?.layer.add(trasition, forKey: kCATransition)
            
            rootViewController.present(resultController, animated: false, completion: nil)
        }
    }
    
    func settingBtnItemClicked() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") // todo setting cotroller link
        
        self.pushViewController(vc, animated: true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
