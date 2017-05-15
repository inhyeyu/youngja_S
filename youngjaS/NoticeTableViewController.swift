//
//  NoticeTableViewController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 23..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class NoticeTableViewController: UITableViewController {

    var noticeRefresh: UIRefreshControl!
    
    class TableViewHelper {
        
        class func EmptyMessage(message:String, viewController:UITableViewController) {
                        
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
            
            messageLabel.text = message
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
            messageLabel.sizeToFit()
            
            viewController.tableView.backgroundView = messageLabel;
            viewController.tableView.separatorStyle = .none;
        }
    }
    
    @IBAction func noticeBtnClicked(_ sender: Any) {
        let rootViewController:UIViewController = (self.navigationController?.viewControllers.first)!
        
        if let resultController = rootViewController.storyboard!.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            
            let trasition = CATransition()
            trasition.duration = 0.3
            trasition.type = kCATransitionPush
            trasition.subtype = kCATransitionFromLeft
            rootViewController.view.window?.layer.add(trasition, forKey: kCATransition)
            
            rootViewController.present(resultController, animated: false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        noticeRefresh = UIRefreshControl()
        noticeRefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(noticeRefresh)
        self.navigationController?.navigationBar.barTintColor = Constant.ColorConst.mainColor

    }
    
    func refresh(){
        print("refresh@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        noticeRefresh.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        if (self.tableView.numberOfSections == 0) {
            TableViewHelper.EmptyMessage(message: "새로운 알림이 없습니다.", viewController: self)
        }
        
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
           return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
