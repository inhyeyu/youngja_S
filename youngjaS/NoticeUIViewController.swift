//
//  NoticeUIViewController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 13..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class NoticeUIViewController: UIViewController {

    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension NoticeUIViewController : UITableViewDelegate {
    
}

extension NoticeUIViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        if (tableView.numberOfSections == 0) {
            TableViewHelper.EmptyMessage(message: "새로운 알림이 없습니다.", viewController: self)
        }
        
        
        return 0
    }
    
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        print("2222312312321312371263812888888888")
        return 0
    }
    */
    
    
    
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print("\(noticeTableView.numberOfSections)")
        if (noticeTableView.numberOfSections == 0) {
            print("33333333333333333333333333")
            TableViewHelper.EmptyMessage(message: "새로운 알림이 없습니다.", viewController: self)
        }
      
        return 0
    }
    */
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "circleTableViewCell", for: indexPath) as! CircleTableViewCell
        
        cell.circleNameLabel.text = data[indexPath.row].circleName
        cell.circleDescriptionLabel.text = data[indexPath.row].circleDescription
        
        if let url = data[indexPath.row].circleBackImageUrl {
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.sync() {
                    //self.imageView.image = UIImage(data: data)
                    cell.circleImageView.image = UIImage(data: data)
                }
            }
            
            task.resume()
        } else {
            cell.circleImageView.image = UIImage(named:"group_default")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        let rootViewController:UIViewController = (self.navigationController?.viewControllers.first)!
        
        if let resultController = rootViewController.storyboard!.instantiateViewController(withIdentifier: "SubTabBarController") as? UITabBarController {
            
            let trasition = CATransition()
            trasition.duration = 0.3
            trasition.type = kCATransitionPush
            trasition.subtype = kCATransitionFromRight
            rootViewController.view.window?.layer.add(trasition, forKey: kCATransition)
            
            rootViewController.present(resultController, animated: false, completion: nil)
        }
    }
 */
}


class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController:NoticeUIViewController) {
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.noticeTableView.backgroundView = messageLabel
        viewController.noticeTableView.separatorStyle = .none
        
        //viewController.tableView.backgroundView = messageLabel;
        //viewController.tableView.separatorStyle = .none;
    }
}
