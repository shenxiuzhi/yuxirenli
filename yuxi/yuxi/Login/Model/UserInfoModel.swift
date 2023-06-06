//
//  UserInfoModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/7.
//

import UIKit
import CoreData
import SwiftyJSON


class UserInfoModel: NSObject {
    
    /**
     * 手机号码
     */
    var mobile: Int64 = 0
    /**
     * 职位
     */
    var zw: String = ""
    /**
     * 用户头像
     */
    var avatar: String = ""
    /**
     * 0, 女 1,男 2, 保密
     */
    var sex: Int16 = 0
    /**
     * 用户ID
     * 唯一标识（主键）
     */
    var ssId: Int64 = 0
    /**
     * 5-9位数字,用户显示ID
     */
    var username: String = ""
    /**
     *  部门
     */
    var dep: String = ""
    /**
     *  loginKey
     */
    var loginKey: String = ""{
        didSet{
            
        }
    }
    /**
     *
     */
    var isleader: Int64 = 0
    /**
     工号
     */
    var number: String = ""
    /**
     *
     */
    var jobNumber:Int64 = 0
    /**
     *  refresh_token
     */
    var refresh_token: String = ""
    /**
    *  userId
    */
    var userId:Int64 = 0
    /**
    *  expTime
    */
    var expTime: Int64 = 0
    /**
    *  access_token
    */
    var access_token: String = ""
    
    
    class func getUserdepData(json: JSON) -> UserInfoModel{
        let model = UserInfoModel.init()
        
        model.mobile = json["mobile"].int64Value
        model.zw = json["zw"].stringValue
        model.avatar = json["avatar"].stringValue
        
        model.sex = json["sex"].int16Value
        model.ssId = json["ssId"].int64Value
        model.username = json["username"].stringValue
        model.dep = json["dep"].stringValue
        model.isleader = json["isleader"].int64Value
        model.number = json["number"].stringValue
        model.jobNumber = json["jobNumber"].int64Value
        model.refresh_token = json["refresh_token"].stringValue
        model.userId = json["userId"].int64Value
        model.expTime = json["expTime"].int64Value
        model.access_token = json["access_token"].stringValue
        
        if model.ssId == UserInfo.mr_findFirst()?.ssId{
            if json["mobile"].exists(){
                UserInfo.mr_findFirst()?.mobile = json["mobile"].int64Value
            }
            if json["zw"].exists(){
                UserInfo.mr_findFirst()?.zw = json["zw"].stringValue
            }
            if json["profilePath"].exists(){
                UserInfo.mr_findFirst()?.avatar = json["avatar"].stringValue
            }
            if json["username"].exists(){
                UserInfo.mr_findFirst()?.username = json["username"].stringValue
            }
            if json["sex"].exists(){
                UserInfo.mr_findFirst()?.sex = json["sex"].int16Value
            }
            if json["dep"].exists(){
                UserInfo.mr_findFirst()?.dep = json["dep"].stringValue
            }
            if json["isleader"].exists(){
                UserInfo.mr_findFirst()?.isleader = json["isleader"].int64Value
            }
            if json["refresh_token"].exists(){
                UserInfo.mr_findFirst()?.refresh_token = json["refresh_token"].stringValue
            }
            if json["userId"].exists(){
                UserInfo.mr_findFirst()?.userId = json["userId"].int64Value
            }
            if json["expTime"].exists(){
                UserInfo.mr_findFirst()?.expTime = json["expTime"].int64Value
            }
            if json["access_token"].exists(){
                UserInfo.mr_findFirst()?.access_token = json["access_token"].stringValue
            }
            if json["number"].exists() {
                UserInfo.mr_findFirst()?.access_token = json["number"].stringValue
            }
            
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
        
        return model
    }
    
    class func userData(content: JSON) {
        //获取一下上下文对象
        let defaultContext = NSManagedObjectContext.mr_default()
        if let arr = UserInfo.mr_findAll() as? [UserInfo]{
            if arr.count > 0{
                for user: UserInfo in arr{
                    user.mr_deleteEntity()
                    defaultContext.mr_saveToPersistentStoreAndWait()
                }
            }
        }
        
//        Growing.setUserId(content["accId"].stringValue)
        
        // 在当前上下文环境中创建一个新的对象
        guard let userInfo = UserInfo.mr_createEntity(in: defaultContext) else {return}
        Dprint("=====loginKey变更了======, 由\(UserInfo.mr_findFirst()?.loginKey ?? "")变为\(content["loginKey"].stringValue)")
        userInfo.mobile = content["mobile"].int64Value
        userInfo.zw = content["zw"].stringValue
        userInfo.avatar = content["avatar"].stringValue
        userInfo.loginKey = content["loginKey"].stringValue
        userInfo.username = content["username"].stringValue
        userInfo.ssId = content["ssId"].int64Value
        userInfo.sex = content["sex"].int16Value
        userInfo.dep = content["dep"].stringValue
        userInfo.isleader = content["isleader"].int64Value
        userInfo.refresh_token = content["refresh_token"].stringValue
        userInfo.userId = content["userId"].int64Value
        userInfo.expTime = content["expTime"].int64Value
        userInfo.access_token = content["access_token"].stringValue
        userInfo.number = content["number"].stringValue
        // 保存修改到当前上下文中
        defaultContext.mr_saveToPersistentStoreAndWait()
    }  //存储个人信息数据

}
