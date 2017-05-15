//
//  CircleViewController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 6..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CircleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var actionButton: ActionButton!
    
    var circleRefresh: UIRefreshControl!
    var circleIds: [String] = []
    
    var data = [Memberr]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton = ActionButton(attachedToView: self.view, items: nil)
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControlState())
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        
        BasketUtil.setActionBtn(actionBtn: actionButton)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "CircleTableViewCell", bundle: nil), forCellReuseIdentifier: "circleTableViewCell")
        self.tableView.separatorStyle = .none
        
        getCircleList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(CircleViewController.getCircleList), name: tokenReadyNotification, object: nil)
        
        circleRefresh = UIRefreshControl()
        circleRefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(circleRefresh)
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        
        BasketUtil.setCircleViewController(circleViewCntrl: self)
        
        /* newtwork check test
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        updateUserInterface()
        */
 
    }
    
    func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        print("Newtwork status ============================")
        print(status)
        print("Newtwork status ============================/")
        switch status {
        case .unreachable:
            view.backgroundColor = .red
        case .wifi:
            view.backgroundColor = .green
        case .wwan:
            view.backgroundColor = .yellow
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    
    func statusManager(_ notification: NSNotification) {
        updateUserInterface()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // refresh control을 table view 뒤로 보내기!
        self.circleRefresh.superview?.sendSubview(toBack: self.circleRefresh)
    }
    
    func refresh(){
        getCircleList()
        circleRefresh.endRefreshing()
    }
    
    func getCircleList() {
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            
            let headers:HTTPHeaders = ["Accept":"application/json"
                , "Content-Type":"application/json"
                , "x-auth-token": "\(token)"
                , "redirect": "follow"
                , "follow": "3"
                , "timeout": "10000"
                , "compress": "true"
                , "size": "0"
                , "body": "null"
                , "agent": "null"]
          
            
            Alamofire.request("https://stage-api.moimdomo.com/members?size=9999&sort=createdAt,desc"
                , method: .get
                , encoding: JSONEncoding.default
                , headers: headers).responseObject{(response: DataResponse<CircleList>) in
                let circleListResponse = response.result.value
                    
                if let members = circleListResponse?.members {
                    self.data = members
                    for memberss in self.data {
                        self.circleIds.append(memberss.circleId!)
                    }
                }
                
                UserDefaults.standard.set(self.circleIds, forKey: "circleIds")
                NotificationCenter.default.post(name: initCompleteNotification, object: self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension CircleViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
 
}

extension CircleViewController : UITableViewDataSource {
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
                    cell.circleImageView.clipsToBounds = true
                }
            }
            
            task.resume()
        } else {
            cell.circleImageView.image = UIImage(named:"group_default")
            cell.circleImageView.clipsToBounds = true
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
            
            UserDefaults.standard.set(data[indexPath.row].circleId, forKey: "currentCircleId")
            UserDefaults.standard.set(data[indexPath.row].circleName, forKey: "currentCircleName")
            
            rootViewController.present(resultController, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

