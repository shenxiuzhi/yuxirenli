//
//  Tools.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/16.
//

import UIKit
import SwiftyJSON
import AVKit
import Alamofire
import CoreLocation

class Tools: NSObject {
    
    /// Date转日期字符串
    ///
    /// - Parameters:
    ///   - date: Date类型
    ///   - dateFormat: 格式化样式默认“yyyy-MM-dd”
    /// - Returns: 日期字符串
    static func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
    /// 日期字符串转Date
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
    /// - Returns: Date类型
    static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    
    // MARK: - 当前时间转时间戳(毫秒级)
    class func currwntDateToMilliTimeStamp() ->Int64 {
        let nowDate = Date()
        let dateStamp:TimeInterval = nowDate.timeIntervalSince1970
        let dateSt:Int64 = CLongLong(round(dateStamp*1000))
        return dateSt
    }
    
    // MARK: - 当前时间转时间戳
    class func currwntDateToTimeStamp() ->Int64 {
        let nowDate = Date()
        let dateStamp:TimeInterval = nowDate.timeIntervalSince1970
        let dateSt:Int64 = Int64(dateStamp)
        return dateSt
    }
    
    // MARK: - 时间戳转时间
    class func timeStampToString(timeStamp:Double, dateFormat:String)->String {
        let timeSta:TimeInterval = timeStamp
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat //"yyyy-MM-dd HH:mm:ss"
        
        let date = Date.init(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date as Date)
    }
    
    // MARK: - 日期字符串转时间戳(秒)
//    class func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Int64 {
//        let dateFormatter = DateFormatter.init()
//        dateFormatter.dateFormat = dateFormat
//        let date = dateFormatter.date(from: string)//"yyyy-MM-dd HH:mm:ss"
//        let dateStamp:TimeInterval = date!.timeIntervalSince1970
//        let dateSt:Int64 = CLongLong(round(dateStamp))
//        return dateSt
//    }
    
    class func getDataWithString(_ year:Int)->Date{
        var compt = DateComponents.init()
        compt.year = year
        let calendar = NSCalendar.current
        let date = calendar.date(from: compt) ?? Date()
        return date
        
    }
    
    //判断是不是在中国
    class func isLocationOutOfChina(location:CLLocationCoordinate2D) -> Bool{
        if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271){
            return true
        }
        return false
    }
    
    //自动登录
    func autoLoginInterface() {
        SURLRequest.sharedInstance.requestPostWithUrl(URL_AutoLogin, param: nil) {[weak self] data in
            if let weakself = self {
                let json = JSON(data)
                Dprint("URL_AutoLogin:\(json)")
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                if code == 200 {
                    
                }else{
                    
                }
            }
        } err: { [weak self] error in
            Dprint("Login_loginerror====== \(error)")
            
        }
    }
    
    //是否开启定位权限
    class func IsOpenLocation() -> Bool{
        let authStatus = CLLocationManager.authorizationStatus()
        return authStatus != .restricted && authStatus != .denied
    }
    
    // 检查麦克风/相机权限
    class func requestAccessFor(type:AVMediaType){
        
        let state = AVCaptureDevice.authorizationStatus(for: type)
        
        Tools.showAlertWith(type: type, state: state)
    }
    
    class func showAlertWith(type:AVMediaType, state: AVAuthorizationStatus){
        switch type {
        case .video: //相机权限
            if state == .restricted || state == .denied {

                let alertCtrl = UIAlertController.init(title: "提示", message: "未开启相机权限,请到前往中开启", preferredStyle: .alert)
                alertCtrl.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
                alertCtrl.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (alertAct) in
                    UIApplication.shared.canOpenURL(URL.init(string: UIApplication.openSettingsURLString)!)
                }))
                UIViewController.getCurrentViewCtrl().present(alertCtrl, animated: true, completion: nil)
            }
            break
//        case .audio: //麦克风权限
//            if state == .restricted || state == .denied {
//                let alertCtrl = UIAlertController.init(title: "提示", message: "未开启麦克风权限,请到前往中开启", preferredStyle: .alert)
//                alertCtrl.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
//                alertCtrl.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (alertAct) in
//                    let settingURL = URL(string: UIApplication.openSettingsURLString)
//                    if UIApplication.shared.canOpenURL(settingURL!){
//                      UIApplication.shared.openURL(settingURL!)
//                    }
//                }))
//                UIViewController.getCurrentViewCtrl().present(alertCtrl, animated: true, completion: nil)
//            }
//            break
       
        default:
            break
        }
        
        
    }
//    //是否开启相机权限
//    func IsOpenCamera() -> Bool{
//        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
//        return authStatus != .restricted && authStatus != .denied
//    }
    
    typealias OperationBlock = ()->()
    // 相机权限
    class func cameraPermissions(authorizedBlock: OperationBlock?, deniedBlock: OperationBlock?) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

            // .notDetermined .authorized .restricted .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            self.cameraPermissions(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
                
            })
        } else if authStatus == .authorized {
            if authorizedBlock != nil {
                authorizedBlock!()
            }
        } else {
            if deniedBlock != nil {
                deniedBlock!()
            }
        }
    }
    
    typealias StringVoidBlock = (JSON)->(Void)
    typealias JSONVoidBlock = (JSON)->(Void)

    /// 多图上传,带参数(必须用formdata表单上传)
        /// - Parameters:
        ///   - apiName: 接口方法名
        ///   - method: HTTP请求的方法名（POST、PUT等）
        ///   - params: 需要传递的参数
        ///   - images: 上传的图片数组
        ///   - success: 成功回调
        ///   - fail: 失败回调
        static func upload(apiName:String,method:HTTPMethod,params:[String:Any]?,images:[UIImage],success: JSONVoidBlock?,fail:StringVoidBlock?) {

            let fullStr = "" + apiName
            /// 设置公共参数
            let token = "token" /// 这是你们httpHeader用到的token

            let httpHeader: HTTPHeaders = [
                "Authorization": token,
                "Content-type": "multipart/form-data"
            ]

            AF.upload(multipartFormData: { (multipartFormData) in

                if params != nil {
                    for (key, value) in params! {
                        let data_ = "\(value)".data(using: String.Encoding.utf8)!
//                        HLog(message: data_)
                        multipartFormData.append(data_, withName: key)
                    }
                }

                for index in 0..<images.count {
                    let img = images[index]
                    if let imgData = img.jpegData(compressionQuality: 0.2) {
                        multipartFormData.append(imgData, withName: "files",fileName: "image_\(index).png", mimeType: "image/png")
                    }
                }

            }, to: fullStr ,method: method,headers: httpHeader) { (encodingResult) in
                // SessionManager.MultipartFormDataEncodingResult
                print("UPLOAD请求url----->" + fullStr)
                print("UPLOAD请求params-----> \(params ?? [:])")

//                switch encodingResult {
//                case .success(let upload, let a, let b):
//                    upload.responseJSON { response in
//                        /// 上传成功
//                        guard response.result.isSuccess else {
//                            /// 网络链接错误或者服务器故障
//                            if fail != nil {
//                                fail!("网络链接错误或者服务器故障")
//                            }
//                            return
//                        }
//
//                        let json = JSON(response.result.value as Any)
//                        let msg = json["message"].stringValue
//                        let code = json["code"].intValue
//                        if code == 200 {
//                            /// 成功
//                            if success != nil {
//                                success!(json["data"])
//                            }
//
//                            print(json["data"])
//
//                        }else if code == 401 {
//                            /// token 失效,重新登录
//                            if fail != nil {
//                                fail!("登录失败，请重新登录")
////                                ELUser.share.userModel = nil
////                                toLogin()
//                            }
//                        }else {
//                            /// 失败
//                            if fail != nil {
////                                fail!(msg)
//                            }
//                        }
//                    }
//
//                case .failure(let encodingError, let a, let b):
//                    if fail != nil {
//                        fail!(encodingError.localizedDescription)
//                    }
//                }
            }
        }
    
    static func uploads(apiName:String,method:HTTPMethod,params:[String:Any]?,images:UIImage,success: JSONVoidBlock?,fail:StringVoidBlock?) {
        
        /// 设置公共参数
        if let token = UserInfo.mr_findFirst()?.access_token {/// 这是你们httpHeader用到的token
            let urlString = apiName
            let httpHeaders = HTTPHeaders([
                "Authorization": token,
                "Content-type": "multipart/form-data"
            ])
            let imageData : Data = images.jpegData(compressionQuality: 0.5)!
            let imageName: Int = 8888
            Alamofire.AF.upload(multipartFormData: { multiPart in
                if params != nil {
                    for (key, value) in params! {
                        let data_ = "\(value)".data(using: String.Encoding.utf8)!
    //                        HLog(message: data_)
                        multiPart.append(data_, withName: key)
                    }
                }
                multiPart.append(imageData, withName: "file", fileName: "\(imageName).jpg", mimeType: "image/jpg")
            }, to: urlString, method: method, headers: httpHeaders).uploadProgress(queue: .main) { progress in
                debugPrint(progress)
//                if success != nil {
//                    success!()
//                }
            }.responseJSON { res in
                debugPrint(res)
                let result = res.result
                switch result {
                case let .success(value):
                    let json = JSON(value)
                    let rawDictionary = json["rawDictionary"]["pairs"]
                    let code = rawDictionary["code"].intValue
                    if success != nil{
                        success!(JSON(rawValue: value)!)
                    }
                    break
                default:
                    break
                }
                
            }
            
        }
    }
    
    
    
    
}
