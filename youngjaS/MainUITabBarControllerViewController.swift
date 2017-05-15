//
//  MainUITabBarControllerViewController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 21..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class MainUITabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for a in self.tabBar.items! {
            print("start")
            print("\(a.title)")
            print("end")
        }
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
    }
 

}
