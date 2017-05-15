//
//  NewsViewController.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 13..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var inNewsTableView: UITableView!
    var currentTableView: UITableView? = nil
    var currentTableViewRestrId: String = ""
    var newsRefresh: UIRefreshControl!
    var heightt: Int = 270
    var newsCell: NewsTableViewCell? = nil
    
    let inNews:String = "inNews"
    let news:String = "news"
    
    var isInNews:Bool = false
    
    var data = [Article]() {
        didSet {
            data = data.sorted { (this:Article, that:Article) -> Bool in
                guard let thisCreatedAt = this.createdAt,
                      let thatCreatedAt = that.createdAt else { return false }
                
                return (thisCreatedAt.compare(thatCreatedAt) == .orderedDescending)
            }
            
            currentTableView?.reloadData()
        }
    }
    
    var dataCount = Int() {
        didSet {
            currentTableView?.reloadData()
        }
    }
    
    var circleIds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTableViewRestrId = self.restorationIdentifier!
        
        if (currentTableViewRestrId == news) {
            currentTableView = self.newsTableView
        } else {
            currentTableView = self.inNewsTableView
            isInNews = true
        }
        
        if (isInNews) {
            
            
            
            // TODO 공지사항 cell 추가!
            //let insideView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 100))
            //currentTableView?.addSubview(insideView)
        
        }
        
        
        currentTableView?.delegate = self
        currentTableView?.dataSource = self
        
        currentTableView?.register(UINib.init(nibName: "NewsNoticeTableViewCell", bundle: nil), forCellReuseIdentifier: "newsNoticeTableViewCell")
        currentTableView?.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsTableViewCell")
        
        getNewsList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewsViewController.getNewsList), name: initCompleteNotification, object: nil)
        
        currentTableView?.backgroundColor = UIColor.groupTableViewBackground
        currentTableView?.separatorStyle = .none
        newsRefresh = UIRefreshControl()
        newsRefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        currentTableView?.addSubview(newsRefresh)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        self.data = []
        getNewsList()
        NotificationCenter.default.post(name: newsListRefreshNotification, object: self)
        
        newsRefresh.endRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // refresh control을 table view 뒤로 보내기!
        self.newsRefresh.superview?.sendSubview(toBack: self.newsRefresh)
    }
    
    func getNewsList() {

        if let token = UserDefaults.standard.string(forKey: "token") {

            if (isInNews) {
                var tempCircleId: [String] = []
                let currentCircleId = UserDefaults.standard.string(forKey: "currentCircleId")
                tempCircleId.append(currentCircleId!)
                
                circleIds = tempCircleId
            } else {
                circleIds = UserDefaults.standard.array(forKey: "circleIds") as! [String]
            }

            for circleId in circleIds {
                
                print("## circleId : " + "\(circleId)")
                
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
                
                
                Alamofire.request(Constant.Host.apiServer + "/circles/" + circleId + "/articles?page=0&size=20&sort=createdAt,desc"
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
                            self.dataCount = articles.count
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

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (isInNews) {
            if(indexPath.section == 0) {
                let noticeCell = currentTableView?.dequeueReusableCell(withIdentifier: "newsNoticeTableViewCell", for: indexPath) as! NewsNoticeTableViewCell
                noticeCell.countLbl.text = "\(self.dataCount)"
 
                heightt = 60
                return noticeCell
                
            } else {
                let cell = currentTableView?.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as! NewsTableViewCell
                newsCell = cell
                
                cell.circleNameLbl.text = data[indexPath.row].circleName
                cell.profileName.text = data[indexPath.row].profileName
                cell.contents.text = data[indexPath.row].thumbnail
                cell.contents.contentMode = .topLeft
                
                if let url = data[indexPath.row].profileImageThumbnailUrl {
                    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.sync() {
                            cell.profileImage.image = UIImage(data: data)
                            cell.profileImage.clipsToBounds = true
                        }
                    }
                    
                    task.resume()
                } else {
                    cell.profileImage.image = UIImage(named:"default_user")
                    cell.profileImage.clipsToBounds = true
                }
                
                if let createdAt = data[indexPath.row].createdAt {
                    cell.writeTimeLbl.text = TimeUtil.calcRemainDate(targetDate: TimeUtil.createDate(fromString: createdAt))
                }
                
                if let commentsCnt = data[indexPath.row].commentCount {
                    cell.commentsCnt.text = "\(commentsCnt)"
                }
                
                if let feelingGoodCount = data[indexPath.row].feelingGoodCount {
                    cell.likeCnt.text = "\(feelingGoodCount)"
                }
                
                if let feelingGoodByMe = data[indexPath.row].feelingGoodByMe {
                    cell.like = feelingGoodByMe
                }
                
                if let articleId = data[indexPath.row].articleId {
                    cell.articleId = articleId
                }
                
                if let isNotice = data[indexPath.row].isNotice {
                    cell.isNotice = isNotice
                }
                
                if let circleId = data[indexPath.row].circleId {
                    cell.circleId = circleId
                }
                
                if let articleWriterId = data[indexPath.row].articleWriterId {
                    cell.articleWriterId = articleWriterId
                }
                
                
                if let imageContents = data[indexPath.row].imageContents {
                    
                    cell.imageContentsData = imageContents
                    if (imageContents.count == 1) {
                        heightt = 470
                    } else if (imageContents.count > 1) {
                        heightt = 425
                    }
                    
                    NotificationCenter.default.post(name: newsImageContentsReadyNotification, object: self)
                    
                } else {
                    cell.imageContentsData = []
                    heightt = 270
                    
                    NotificationCenter.default.post(name: newsImageContentsReadyNotification, object: self)
                }
                
                
                cell.parent = self
                
                return cell
            }

        } else {
            let cell = currentTableView?.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as! NewsTableViewCell
            newsCell = cell
            
            cell.circleNameLbl.text = data[indexPath.row].circleName
            cell.profileName.text = data[indexPath.row].profileName
            cell.contents.text = data[indexPath.row].thumbnail
            cell.contents.contentMode = .topLeft
            
            if let url = data[indexPath.row].profileImageThumbnailUrl {
                let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.sync() {
                        //self.imageView.image = UIImage(data: data)
                        cell.profileImage.image = UIImage(data: data)
                        cell.profileImage.clipsToBounds = true
                    }
                }
                
                task.resume()
            } else {
                cell.profileImage.image = UIImage(named:"default_user")
                cell.profileImage.clipsToBounds = true
            }
            
            if let createdAt = data[indexPath.row].createdAt {
                cell.writeTimeLbl.text = TimeUtil.calcRemainDate(targetDate: TimeUtil.createDate(fromString: createdAt))
            }
            
            if let commentsCnt = data[indexPath.row].commentCount {
                cell.commentsCnt.text = "\(commentsCnt)"
            }
            
            if let feelingGoodCount = data[indexPath.row].feelingGoodCount {
                cell.likeCnt.text = "\(feelingGoodCount)"
            }
            
            if let feelingGoodByMe = data[indexPath.row].feelingGoodByMe {
                cell.like = feelingGoodByMe
            }
            
            if let articleId = data[indexPath.row].articleId {
                cell.articleId = articleId
            }
            
            if let isNotice = data[indexPath.row].isNotice {
                cell.isNotice = isNotice
            }
            
            if let circleId = data[indexPath.row].circleId {
                cell.circleId = circleId
            }
            
            if let articleWriterId = data[indexPath.row].articleWriterId {
                cell.articleWriterId = articleWriterId
            }
            
            
            if let imageContents = data[indexPath.row].imageContents {
                
                cell.imageContentsData = imageContents
                if (imageContents.count == 1) {
                    heightt = 470
                } else if (imageContents.count > 1) {
                    heightt = 425
                }
                
                NotificationCenter.default.post(name: newsImageContentsReadyNotification, object: self)
                
            } else {
                cell.imageContentsData = []
                heightt = 270
                
                NotificationCenter.default.post(name: newsImageContentsReadyNotification, object: self)
            }
            
            
            cell.parent = self
            
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isInNews) {
            if (section == 0) {
                return 1
            } else {
                return data.count
            }
        } else {
            return data.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (isInNews) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentTableView?.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.section == 0) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsNoticeViewController")
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            /*let rootViewController:UIViewController = (self.navigationController?.viewControllers.first)!
            
            if let resultController = rootViewController.storyboard!.instantiateViewController(withIdentifier: "NewsNoticeViewController") as? UINavigationController {
                
                let trasition = CATransition()
                trasition.duration = 0.3
                trasition.type = kCATransitionPush
                trasition.subtype = kCATransitionFromRight
                rootViewController.view.window?.layer.add(trasition, forKey: kCATransition)
                
                rootViewController.present(resultController, animated: false, completion: nil)
            }
            */
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}


extension NewsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightt)
    }
}
