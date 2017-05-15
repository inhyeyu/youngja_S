//
//  NewsTableViewCell.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 13..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var circleNameLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var writeTimeLbl: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var likeCnt: UILabel!
    @IBOutlet weak var commentsCnt: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var articleId: String = ""
    var articleWriterId: String = ""
    var circleId: String = ""
    var isNotice: Bool = false
    var hasImage: Bool = false
    var parent: NewsViewController? = nil
    //var imageContentsData:[ImageContent] = []
    
    var imageContentsData = [ImageContent]() {
        didSet {
            //self.collectionView(self, imageContentsData.count)
            //self.newsTableView.reloadData()
            print("Set Image Content Data === :: " + "\(imageContentsData.count)")
            self.imageCollectionView.reloadData()
            
        }
    }
    
    var like = Bool() {
        didSet {
            initHeart()
        }
    }
    
    func initHeart() {
        if (like == false) {
            likeBtn.setImage(UIImage(named: "heart_unlike"), for: UIControlState.normal)
        } else {
            likeBtn.setImage(UIImage(named: "heart_like"), for: UIControlState.normal)
        }
    }
    
    @IBAction func optionMenuBtnClicked(_ sender: Any) {
        let optionMenuController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        var setNoticeMenuStr = "공지로 설정하기"
        var alertSetNoticeStr = "공지로 설정하시겠습니까?"
        var alertSetNoticeChkStr = "공지로 설정되었습니다."
        if (isNotice) {
            setNoticeMenuStr = "공지 해제하기"
            alertSetNoticeStr = "공지를 해제하시겠습니까?"
            alertSetNoticeChkStr = "공지가 해제되었습니다."
        }
        
        // '공지로 설정하기' 버튼 클릭 이벤트
        let setNoticeBtn = UIAlertAction(title: setNoticeMenuStr, style: .default, handler: { (action) -> Void in
            let setNoticeAlert = UIAlertController(title: "알림", message: alertSetNoticeStr, preferredStyle: UIAlertControllerStyle.alert)
            setNoticeAlert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.default, handler: nil))
            
            setNoticeAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { action in
                if (self.isNotice) { // 공지 해제
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
                        
                        Alamofire.request(Constant.Host.apiServer + "/circles/" + self.circleId + "/members?status=ENABLED"
                            , method: .get
                            , encoding: JSONEncoding.default
                            , headers: headers).responseObject{(response: DataResponse<CircleList>) in
                                
                                let circleListResponse = response.result.value
                                
                                if let members = circleListResponse?.members {
                                    if let resultRole = members[0].circleMemberRole {
                                        if (PermissionUtil.isMaster(role: resultRole)) {
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
                                                
                                                Alamofire.request(Constant.Host.apiServer + "/articles/" + self.articleId + "/notice"
                                                    , method: .delete
                                                    , encoding: JSONEncoding.default
                                                    , headers: headers).response(completionHandler: { response in
                                                        self.parent?.refresh()
                                                    })
                                            }
                                        } else {
                                            alertSetNoticeChkStr = "공지 해제 권한이 없습니다."
                                        }
                                        
                                        let setNoticeChkAlert = UIAlertController(title: "알림", message: alertSetNoticeChkStr, preferredStyle: UIAlertControllerStyle.alert)
                                        setNoticeChkAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                                        
                                        self.topMostController().present(setNoticeChkAlert, animated: true, completion: nil)
                                    }
                                }
                        }
                    }
                } else { // 공지 설정
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
                        
                        Alamofire.request(Constant.Host.apiServer + "/articles/" + self.articleId + "/notice"
                            , method: .put
                            , encoding: JSONEncoding.default
                            , headers: headers).response(completionHandler: { response in
                                self.parent?.refresh()
                            })
                    }
                    
                    let setNoticeChkAlert = UIAlertController(title: "알림", message: alertSetNoticeChkStr, preferredStyle: UIAlertControllerStyle.alert)
                    setNoticeChkAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    
                    self.topMostController().present(setNoticeChkAlert, animated: true, completion: nil)
                    
                }
            })
            
            self.topMostController().present(setNoticeAlert, animated: true, completion: nil)
        })
        
        // '수정하기' 버튼 클릭 이벤트
        let editBtn = UIAlertAction(title: "수정하기", style: .default, handler: { (action) -> Void in
            
            
        })
        
        // '삭제하기' 버튼 클릭 이벤트
        let deleteBtn = UIAlertAction(title: "삭제하기", style: .default, handler: { (action) -> Void in
            
            let setDeleteAlert = UIAlertController(title: "알림", message: "글을 삭제하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
            setDeleteAlert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.default, handler: nil))
            
            setDeleteAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { action in
                
                
                
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
                    
                    Alamofire.request(Constant.Host.apiServer + "/circles/" + self.circleId + "/members?status=ENABLED"
                        , method: .get
                        , encoding: JSONEncoding.default
                        , headers: headers).responseObject{(response: DataResponse<CircleList>) in
                            
                            let circleListResponse = response.result.value
                            
                            if let members = circleListResponse?.members {
                                if let resultRole = members[0].circleMemberRole, let memberUserId = members[0].memberUserId {
                                    if (PermissionUtil.isMaster(role: resultRole)
                                        || PermissionUtil.isMyArticle(memberUserId: memberUserId, articleWriterId: self.articleWriterId)) {
                                        
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
                                            
                                            Alamofire.request(Constant.Host.apiServer + "/articles/" + self.articleId
                                                , method: .delete
                                                , encoding: JSONEncoding.default
                                                , headers: headers).response(completionHandler: { response in
                                                    
                                                    let setDeleteCompleteAlert = UIAlertController(title: "알림", message: "글이 삭제되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                                                    setDeleteCompleteAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { action in
                                                        self.parent?.refresh()
                                                    })
                                                    
                                                    self.topMostController().present(setDeleteCompleteAlert, animated: true, completion: nil)
                                                })
                                        
                                    } else {
                                        let setNoPermToDeleteAlert = UIAlertController(title: "알림", message: "삭제 권한이 없습니다.", preferredStyle: UIAlertControllerStyle.alert)
                                        setNoPermToDeleteAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                                            
                                        self.topMostController().present(setNoPermToDeleteAlert, animated: true, completion: nil)
                                    }
                                }
                            }
                    }
                }
            })
            
            self.topMostController().present(setDeleteAlert, animated: true, completion: nil)
      
        })
        
        // '취소' 버튼 클릭 이벤트
        let cancelBtn = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        optionMenuController.addAction(setNoticeBtn)
        optionMenuController.addAction(editBtn)
        optionMenuController.addAction(deleteBtn)
        optionMenuController.addAction(cancelBtn)
        
        topMostController().present(optionMenuController, animated: true, completion: nil)
        
        //self.rootViewController?.present(optionMenuController, animated: true, completion: nil)
    }
    
    
    @IBAction func likeBtnClicked(_ sender: Any) {
        if (like == false) { // like
            let pluslikeCnt:Int = Int(likeCnt.text!)! + 1
            likeCnt.text = "\(pluslikeCnt)"
            like = true
            
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
                
                Alamofire.request(Constant.Host.apiServer + "/articles/" + articleId + "/feelingGoods"
                    , method: .post
                    , encoding: JSONEncoding.default
                    , headers: headers).response(completionHandler: { response in
                        debugPrint(response)
                    })
            }
            
            
        } else { // unlike
            let minuslikeCnt:Int = Int(likeCnt.text!)! - 1
            likeCnt.text = "\(minuslikeCnt)"
            like = false
            
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
                
                Alamofire.request(Constant.Host.apiServer + "/articles/" + articleId + "/feelingGoods"
                    , method: .delete
                    , encoding: JSONEncoding.default
                    , headers: headers).response(completionHandler: { response in
                        debugPrint(response)
                    })
            }

        }
    }
    
    @IBAction func commentsBtnClicked(_ sender: Any) {
        print("comments Btn Click!!!")
    }
    
    override func awakeFromNib() {
        imageContentsData = []
        super.awakeFromNib()
        
        self.imageCollectionView.register(UINib.init(nibName: "NewsImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newsImageCollectionViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewsTableViewCell.imageCollectionInit), name: newsImageContentsReadyNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewsTableViewCell.refresh), name: newsListRefreshNotification, object: nil)
    }

    func refresh() {
        //self.imageContentsData = []
        self.imageCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.lightGray
        contentView.tintColor = UIColor.lightGray
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 0, 0, 0))
    }
    
    func imageCollectionInit() {
        //imageCollectionView.backgroundColor = UIColor.black
        //print("5555555555555 :: " + "\(imageContentsData.count)")
        imageCollectionView.frame.size.height = 0
        
        if (imageContentsData.count > 0) {
            self.imageCollectionView.dataSource = self
            self.imageCollectionView.delegate = self
            
            if (imageContentsData.count == 1) {
                imageCollectionView.frame.size.height = 200
            } else {
                imageCollectionView.frame.size.height = 155
            }
        }
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

extension NewsTableViewCell: UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("1$$$$$$$$$$$$$$$$$$$$" + "\(imageContentsData.count)")
    
        return imageContentsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsImageCollectionViewCell", for: indexPath) as! NewsImageCollectionViewCell
        
        //print("2$$$$$$$$$$$$$$$$$$$$" + "\(imageContentsData.count)")
        
        cell.backgroundColor = UIColor.lightGray
        //cell.testLbl.text = "\(imageContentsData[indexPath.row].seq)"
        //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, heights[indexPath.row])
        //cell.frame = CGRect(cell.frame.origin.x, cell.frame.origin.y, 64, 64)
        //cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: 124, height: 160)
        
        if let url = imageContentsData[indexPath.row].thumbnailUrl {
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.sync() {
                    cell.imageView.image = UIImage(data: data)
                    cell.imageView.contentMode = .scaleAspectFill
                }
            }
            
            task.resume()
        }
        
        
        return cell
    }
}

extension NewsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if imageContentsData.count > 1 {
            return CGSize(width: 160, height: 155)
        } else {
            return CGSize(width: 340, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7.0
    }
}

