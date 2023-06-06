//
//  SURLHelper.swift
//  Sheng
//
//  Created by DS on 2017/7/28.
//  Copyright © 2017年 mac. All rights reserved.
//

/*
 UKL帮助类
 */


import UIKit
import SwiftyJSON
import Toast_Swift
import CryptoSwift

class SURLHelper: NSObject {
    /// 获取 CheckCode dictionary 作为 request header
    /// - Parameter checkArr: request parameters 组成的字符串数组
    /// - Returns: CheckCode dictionary
    class func getCheckCode(checkArr:[String]) -> [String:String] {

        let codeStr = checkArr.joined(separator: "&")
//        let str = codeStr.md5()
        guard let data = codeStr.data(using: String.Encoding.utf8) else {return ["checkSum":""]}
        let codeStr1: String = data.base64EncodedString()
        let dict = ["checkSum":codeStr1, "appVersion": YUXIAPP_VERSION]
        return dict
    }
    
    /// 获取 CheckCode string 作为 request response 指定字段的对比对象
    ///
    /// - Parameter checkArr: request parameters 组成的字符串数组
    /// - Returns: CheckCode string
    class func getResponseMd5String(checkArr:[String]) -> String {
        let codeStr = checkArr.joined(separator: "&")
//        let str = codeStr.md5()
        guard let data = codeStr.data(using: String.Encoding.utf8) else {return ""}
        let codeStr1: String = data.base64EncodedString()
        return codeStr1
    }
    
    /// 获取裁剪图片链接(建议直接使用sdSet)
    ///
    /// - Parameters:
    ///   - imagePath: 图片链接地址
    ///   - side: 要获取的图片边长
    /// - Returns: 图片链接
    class func getNewImageUrl(imagePath:String, side:CGFloat) -> String{
        return SURLHelper.getNewImageUrl(imagePath: imagePath, size: CGSize.init(width: side, height: side))
    }
    
    /// 获取裁剪图片链接(建议直接使用sdSet)
    ///
    /// - Parameters:
    ///   - imagePath: 图片链接地址
    ///   - size: 要获取的图片尺寸
    /// - Returns: 图片链接
    class func getNewImageUrl(imagePath:String, size:CGSize) -> String{
        if ((!imagePath.contains("https://"))&&(!imagePath.contains("http://"))) || imagePath.contains("thirdqq.qlogo.cn") {
            return imagePath
        }
        let imagePathReplace = imagePath
//        if imagePathReplace.contains(SImageStringValueContainFile) { //此路径图片不支持裁剪
//            imagePathReplace = imagePathReplace.replacingOccurrences(of: SImageStringValueContainFile, with: SImageStringValueContainImage)
//        }
        let sizeStr = String.init(format: "?imageView2/1/w/%zd/h/%zd/q/100", Int(size.width)*Int(YUXIScreen_Scale),Int(size.height)*Int(YUXIScreen_Scale))
        let imageUrl = imagePathReplace + sizeStr
        return imageUrl
    }
    
    /// 获取圆角图片链接(建议直接使用sdSet)
    /// 万象ImageMogr2
    /// - Parameters:
    ///   - imagePath: 图片链接地址
    ///   - size: 要获取的图片尺寸
    /// - Returns: 图片链接
    class func getImageMogrUrl(imagePath:String, imageSize: CGSize, cornerRadius: CGFloat) -> String{
        if ((!imagePath.contains("https://"))&&(!imagePath.contains("http://"))) || imagePath.contains("thirdqq.qlogo.cn") {
            return imagePath
        }
        let imagePathReplace = imagePath
//        if imagePathReplace.contains(SImageStringValueContainFile) { //此路径图片不支持裁剪
//            imagePathReplace = imagePathReplace.replacingOccurrences(of: SImageStringValueContainFile, with: SImageStringValueContainImage)
//        }
        var sizeStr = String.init(format: "?imageMogr2/thumbnail/%zdx%zd/rradius/%zd", Int(imageSize.width)*Int(YUXIScreen_Scale),Int(imageSize.height)*Int(YUXIScreen_Scale), Int(cornerRadius*YUXIScreen_Scale))
        if imagePath.contains("jpg") || imagePath.contains("jpeg"){
            sizeStr = String.init(format: "?imageMogr2/thumbnail/%zdx%zd/rradius/%zd/format/png", Int(imageSize.width)*Int(YUXIScreen_Scale),Int(imageSize.height)*Int(YUXIScreen_Scale), Int(cornerRadius*YUXIScreen_Scale))
        }
        
        let imageUrl = imagePathReplace + sizeStr
        return imageUrl
    }
    
    /// 获取原比例图片链接
    ///
    /// - Parameters:
    ///   - imagePath: 图片链接地址
    ///   - width: 要获取的图片宽度
    /// - Returns: 图片链接
    class func getNewImageUrlScale(imagePath:String, width:CGFloat) -> String{
        if ((!imagePath.contains("https://"))&&(!imagePath.contains("http://"))) || imagePath.contains("thirdqq.qlogo.cn") {
            return imagePath
        }
        let imagePathReplace = imagePath
//        if imagePathReplace.contains(SImageStringValueContainFile) { //此路径图片不支持裁剪
//            imagePathReplace = imagePathReplace.replacingOccurrences(of: SImageStringValueContainFile, with: SImageStringValueContainImage)
//        }
        let sizeStr = String.init(format: "?imageMogr2/thumbnail/%zdx", Int(width)*Int(YUXIScreen_Scale))
        let imageUrl = imagePathReplace + sizeStr
        return imageUrl
    }
    
    
    /// 判断登录过期并给出提示
    ///
    /// - Parameter data: 接口返回的数据
    /// - Returns: 是否登录过期
    class func judgeExpiredLoginAndMakeToast(data:Any){
        let dataJson = JSON(data)
        let resultStr = dataJson["result"].stringValue
        if resultStr == "error"{
            let contentJson = dataJson["content"]
            let messageValue = contentJson["message"].intValue
            let statusValue = contentJson["status"].intValue
            if (messageValue == 4010000) && (statusValue == 400){
                 UIViewController.getCurrentViewCtrl().view.makeToast("登录已过期，请重新登录", duration: 1.5, position: .center)
            } else if (messageValue == 7500002) {
                UIViewController.getCurrentViewCtrl().view.makeToast("需要升级到新版本哦~", duration: 1.5, position: .center)
            }
        }
    }
    
    /// 抛异常的后台请求,根据状态码给出toast提示
    ///
    /// - Parameter data: 接口返回的数据
    class func errorResultRequestToMakeStateCodeToast(data:Any) {
        let dataJson = JSON(data)
        let resultStr = dataJson["result"].stringValue
        if resultStr == "error"{
            let contentJson = dataJson["content"]
            let messageValue = contentJson["message"].intValue
            var codeToastStr = ""
            switch messageValue{
            case 4000000:
                codeToastStr = "用户名为空"
                break
            case 4000001:
                codeToastStr = "密码为空"
                break
            case 4000002:
                codeToastStr = "此账号不存"
                break
            case 4000004:
                codeToastStr = "您的设备或账号已被禁封"
                break
            case 4000120:
                codeToastStr = "手机号已注册"
                break
            case 4000122:
                codeToastStr = "验证码错误"
                break
            case 4000123:
                codeToastStr = "当前设备可注册的账号数已达上限，如有疑问请咨询QQ：1442501054"
                break
            case 4010000:
                codeToastStr = "登录已过期，请重新登录"
                break
            case 7000000:
                codeToastStr = "设备异常"//"机器码为空"
                break
            case 7000001:
                codeToastStr = "邀请码有误"
                break
            case 4000005:
                codeToastStr = "登录缓存失效"
                break
            case 6100000:
                codeToastStr = "参数不能为空"
                break
            case 5000000:
                codeToastStr = "服务器异常"
                break
                
            default: //5000000
                codeToastStr = "请求出错"
            }
            UIViewController.getCurrentViewCtrl().view.makeToast(codeToastStr, duration: 2.0, position: .center)
        }
    }
}
