//
//  NewsNoticeViewController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 5. 9..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire

class NewsNoticeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data = [Article]() {
        didSet {
            data = data.sorted { (this:Article, that:Article) -> Bool in
                guard let thisCreatedAt = this.createdAt,
                    let thatCreatedAt = that.createdAt else { return false }
                
                return (thisCreatedAt.compare(thatCreatedAt) == .orderedDescending)
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "공지사항"
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib.init(nibName: "NoticeTableViewCell", bundle: nil), forCellReuseIdentifier: "noticeTableViewCell")
        
        
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        
        getNewsNoticeList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNewsNoticeList() {
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            
            if let currentCircleId = UserDefaults.standard.string(forKey: "currentCircleId") {
                
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
                
                
                Alamofire.request(Constant.Host.apiServer + "/circles/" + currentCircleId + "/articles?notice=true"
                    , method: .get
                    , encoding: JSONEncoding.default
                    , headers: headers).responseObject{(response: DataResponse<NewsList>) in
                        
                        let newsListResponse = response.result.value
                        
                        if let articles = newsListResponse?.articles {
                            self.data.append(contentsOf: articles)
                        } else {
                            print("news is empty")
                        }
                }
            }
            
        }
        
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

extension NewsNoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeTableViewCell", for: indexPath) as! NoticeTableViewCell
        var descStr = ""
        
        noticeCell.textThumbLbl.text = data[indexPath.row].thumbnail
        
        if let writer = data[indexPath.row].profileName {
            descStr = writer
        }
        
        if let date = data[indexPath.row].createdAt {
            descStr += " | " + TimeUtil.createFormatStr(string: date)
        }
        
        noticeCell.writerLbl.text = descStr
        
        return noticeCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

extension NewsNoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

