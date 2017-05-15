//
//  MainUINavigationController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 12..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class MainUINavigationController: UINavigationController {

    var isNewCircleViewOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.topItem?.titleView = UIImageView(image: UIImage(named: "mofin-orange"))
        
        let noticeBtn = UIBarButtonItem(image: UIImage(named: "bell"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainUINavigationController.noticeButtonItemClicked))
        noticeBtn.tintColor = UIColor.orange
        
        let rightBarBtns:[UIBarButtonItem] = [noticeBtn]
        self.navigationBar.topItem?.rightBarButtonItems = rightBarBtns
        
        self.navigationBar.tintColor = UIColor.orange
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func noticeButtonItemClicked() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NoticeViewController")

        self.pushViewController(vc, animated: true)
        
        //TODO hide tab
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setToolbarHidden(_ hidden: Bool, animated: Bool) {
        //self.setToolbarHidden(true, animated: true)
        
    }

}
