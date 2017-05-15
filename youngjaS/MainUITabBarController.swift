//
//  MainUITabBarController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 27..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class MainUITabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = false
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        // let destination = (segue.destination as! UITabBarController).viewControllers?.first as! CircleTableViewController
        print("MainUITabBarController:prepare ================")
    }
}
