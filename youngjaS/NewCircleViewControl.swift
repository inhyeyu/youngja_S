//
//  NewCircleViewControll.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 28..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire

class NewCircleViewControl: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var moimName: UITextField!
    @IBOutlet weak var moinDesc: UITextField!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var moimMaxLbl: UILabel!
    @IBOutlet weak var moimDescMaxLbl: UILabel!
 
    var userId: String = ""
    var imageId: String = ""
    var moimNameStr: String = ""
    var moimDescStr: String = ""
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    @IBAction func changedMoimName(_ sender: Any) {
        if let moim = moimName.text {
            
            if (moim.characters.count <= 20) {
                if (moim.characters.count == 20) {
                    moimMaxLbl.textColor = UIColor.black
                }
                moimMaxLbl.text = "(" + "\(moim.characters.count)" + "/20)"
            }
            else {
                moimMaxLbl.text = "모임명은 20자리 이하입니다. (" + "\(moim.characters.count)" + "/20)"
                moimMaxLbl.textColor = UIColor.orange
            }
        }
        //print("\(moimName.text?.characters.count)")
    }
    
    @IBAction func changedMoimDesc(_ sender: Any) {
        if let moim = moinDesc.text {
            
            if (moim.characters.count <= 50) {
                if (moim.characters.count == 50) {
                    moimDescMaxLbl.textColor = UIColor.black
                }
                moimDescMaxLbl.text = "(" + "\(moim.characters.count)" + "/50)"
            }
            else {
                moimDescMaxLbl.text = "모임 설명은 50자리 이하입니다. (" + "\(moim.characters.count)" + "/50)"
                moimDescMaxLbl.textColor = UIColor.orange
            }
        }
    }
    
    var rootViewController:UIViewController? = nil
    
    override func draw(_ rect: CGRect) {
        cameraBtn.backgroundColor = UIColor.white
        cameraBtn.frame = CGRect(x: 255, y: 98, width: 40, height: 40)
        cameraBtn.layer.cornerRadius = cameraBtn.bounds.size.width / 2
        cameraBtn.layer.masksToBounds = true
        cameraBtn.setImage(UIImage(named:"camera"), for: .normal)
        
        imageView.image = UIImage(named: "group_default")
        rootViewController = self.getTopViewController()!
        
        BasketUtil.setNewCircleViewController(newCircleViewCntrl: self)
        
        self.activityIndicator.center = CGPoint(x:UIScreen.main.bounds.size.width / 2, y:UIScreen.main.bounds.size.height / 2)
        self.addSubview(self.activityIndicator)
    }
    
    func refresh() {
        self.moimName.text = ""
        self.moinDesc.text = ""
        self.imageView.image = UIImage(named: "group_default")
    }

    @IBAction func clickedNextBtn(_ sender: Any) {
        
        print("Next !!! ")
        
        if moimName.text?.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            let emptyMoimNameAlert = UIAlertController(title: "알림", message: "모임명을 입력하세요!", preferredStyle: UIAlertControllerStyle.alert)
            emptyMoimNameAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
            
            self.window?.rootViewController?.present(emptyMoimNameAlert, animated: true, completion: nil)
        }
        
        if let name = moimName.text {
            if (name.characters.count > 20) {
                let overMaxLengthMoimNameAlert = UIAlertController(title: "알림", message: "모임명은 최대 20자 입니다.", preferredStyle: UIAlertControllerStyle.alert)
                overMaxLengthMoimNameAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                
                self.window?.rootViewController?.present(overMaxLengthMoimNameAlert, animated: true, completion: nil)
            }
        }
        
        if let name = moinDesc.text {
            if (name.characters.count > 50) {
                let overMaxLengthMoimDescAlert = UIAlertController(title: "알림", message: "모임 설명은 최대 50자 입니다.", preferredStyle: UIAlertControllerStyle.alert)
                overMaxLengthMoimDescAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                
                self.window?.rootViewController?.present(overMaxLengthMoimDescAlert, animated: true, completion: nil)
            }
        }
        
        if let name = moimName.text {
            let overMaxLengthMoimDescAlert = UIAlertController(title: "알림", message: "\"" + name + "\" 모임을 만드시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
            overMaxLengthMoimDescAlert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.default, handler: nil))
            //overMaxLengthMoimDescAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: #selector(NewCircleViewControl.createCircle)))
            
            overMaxLengthMoimDescAlert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { action in
                self.activityIndicator.startAnimating()
                // 1. 모임 만들기 창 닫기.
                // 2. Image Upload.
                // 3. Circle 생성.
                // 4. 프로필 작성 페이지로 이동 
                //          "프로필 작성 : 모임 프로필 이름은 회비 및 계좌관리 시 사용되는 이름이며, 원활한 모임 운영을 위해 모임 활동기간 동안 공개됩니다."
                //          모임에서 사용하실 이름을 정해주세요.
                
                if let moimNameStr:String = self.moimName.text, let moimDescStr:String = self.moinDesc.text {
                    self.moimNameStr = moimNameStr
                    self.moimDescStr = moimDescStr
                }
                
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
                    
                    
                    Alamofire.request(Constant.Host.apiServer + "/users/me"
                        , method: .get
                        , encoding: JSONEncoding.default
                        , headers: headers).responseObject{(response: DataResponse<UserMe>) in
                            
                            let userMeListResponse = response.result.value
                            
                            if let userId = userMeListResponse?.id {
                                self.userId = userId
                                let uploadUrl = Constant.Host.apiServer + "/files/" + userId
                                let imageData = UIImageJPEGRepresentation(self.imageView.image!, 1.0)
                                print("\(imageData!)")
                         
                                let uploadHeaders:HTTPHeaders = ["Accept":"*/*"
                                    , "Content-Type":"multipart/form-data"
                                    , "x-auth-token": "\(token)"]
                    
                                let parameters = [
                                    "file": "swift_file.jpeg"
                                ]
                                
                                Alamofire.upload(multipartFormData: { (multipartFormData) in
                                    multipartFormData.append(UIImageJPEGRepresentation(self.imageView.image!, 1)!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                                    for (key, value) in parameters {
                                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                                    }
                                }, to:uploadUrl, method:.post,
                                   headers: uploadHeaders)
                                { (result) in
                                    switch result {
                                    case .success(let upload, _, _):
                                        
                                        upload.uploadProgress(closure: { (progress) in
                                            //Print progress
                                        })
                                        
                                        upload.responseObject {(response: DataResponse<Image>) in
                                            //print response.result
                                            let circleCResponse = response.result.value
                                            
                                            if let imageId:String = circleCResponse?.imageId {
                                                self.imageId = imageId
                                                
                                                let ccheaders:HTTPHeaders = ["Accept":"application/json"
                                                    , "Content-Type":"application/json"
                                                    , "x-auth-token": "\(token)"
                                                ]
                                                
                                                let newCircle = ["backgroundImageId":"\(self.imageId)", "description":"\(self.moimDescStr)", "name": "\(self.moimNameStr)"]
                                                
                                                let newCircleRequest: DataRequest = Alamofire.request(Constant.Host.apiServer + "/circles", method: .post, parameters: newCircle, encoding: JSONEncoding.default, headers: ccheaders)
                                                
                                                let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
                                                    if let body = result.value {

                                                        print("result ========================")
                                                        print(body)
                                                        print("result ========================/")
                                                        BasketUtil.getActionBtn().toggle()
                                                        BasketUtil.getCircleViewController().getCircleList()
                                                        self.activityIndicator.stopAnimating()
                                                    }
                                                }
                                                
                                                newCircleRequest.responseString { response in
                                                    requestComplete(response.response, response.result)
                                                }

                                            }
                                        }
                                        
                                    case .failure(let encodingError): break
                                        //print encodingError.description
                                    }
                                }
                                
                                
                                
                                
                            } else {
                                print("news is empty")
                            }
                    }
                }
            })
            
            self.window?.rootViewController?.present(overMaxLengthMoimDescAlert, animated: true, completion: nil)
           
        }
       
        
    }
    
    func addImageData(multipartFormData: MultipartFormData, image: UIImage!) -> MultipartFormData {
        var data = UIImagePNGRepresentation(image!)
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: "targetImage",fileName: "targetImage", mimeType: "image/png")
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 1.0)
            multipartFormData.append((data?.base64EncodedData())!, withName: "targetImage",fileName: "targetImage", mimeType: "image/jpeg")
        }
        return multipartFormData
    }
    
    
    
    @IBAction func clickedCameraBtn(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // '카메라' 버튼 클릭 이벤트
        let cameraButton = UIAlertAction(title: "카메라", style: .default, handler: { (action) -> Void in
            
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.rootViewController?.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alertWarning = UIAlertController(title: "알림", message: "사용 가능한 카메라가 존재하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alertWarning.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                
                self.rootViewController?.present(alertWarning, animated: true, completion: nil)
            }
        })
        
        // '앨범에서 사진 선택' 버튼 클릭 이벤트
        let photoButton = UIAlertAction(title: "앨범에서 사진 선택", style: .default, handler: { (action) -> Void in
           
            imagePicker.sourceType = .photoLibrary
            self.rootViewController?.present(imagePicker, animated: true, completion: nil)
            
        })
        
        // '기본 이미지로 변경' 버튼 클릭 이벤트
        let defaultImageButton = UIAlertAction(title: "기본 이미지로 변경", style: .default, handler: { (action) -> Void in
            print("기본 이미지로 변경 button tapped")
            
            self.imageView.contentMode = .scaleToFill
            self.imageView.image = UIImage(named: "group_default")
        })
      
        // '취소' 버튼 클릭 이벤트
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("취소 button tapped")
        })
        
        alertController.addAction(cameraButton)
        alertController.addAction(photoButton)
        alertController.addAction(defaultImageButton)
        alertController.addAction(cancelButton)
        
        //self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    
        self.rootViewController?.present(alertController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleToFill
            imageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func getTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return getTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        return controller
    }

}
