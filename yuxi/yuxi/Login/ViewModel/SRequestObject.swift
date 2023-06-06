//
//  SRequestObject.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/23.
//

import UIKit
import SwiftyJSON

/// 项目公用请求管理对象
class SRequestObject: NSObject {
    /// 单例
    @objc class var shared: SRequestObject {
        struct instance {
            static let _instance:SRequestObject = SRequestObject()
        }
        return instance._instance
    }
    
    
    //退出登录接口
    func exitLoginInterface() {
        SURLRequest.sharedInstance.requestPostWithUrl(Url_Login_Out, param: nil) {[weak self] data in
            if let weakself = self {
                let json = JSON(data)
                Dprint("Login_login:\(json)")
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                if code == 200 {
                    if let arr = UserInfo.mr_findAll() as? [UserInfo]{
                        if arr.count > 0{
                            let model = arr[0]
                            model.mr_deleteEntity()
                            NSManagedObjectContext .mr_default().mr_saveToPersistentStoreAndWait()
                        }
                    }
                    let vc = YUXILoginAccountController()
                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
                }else{

                }
                
            }
        } err: { [weak self] error in
            Dprint("Login_loginerror====== \(error)")
        }
    }
    
}
