//
//  MyAttendanceModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/17.
//

import UIKit
import SwiftyJSON

class MyAttendanceModel: NSObject {
    
    //打卡时间
    var date:String = ""
    
    //1 签到 2：签退
    var type:Int = 0
    
    //打卡图片
    var image:String = ""
    
    //打卡地址
    var address:String = ""
    
    //打卡ip
    var ip:String = ""
    
    /*
     打卡状态
     0：未打卡 1：正常 2：迟到或早退
     */
    var status:Int = 0
    
    class func getUserdepData(json: JSON) -> MyAttendanceModel{
        let model = MyAttendanceModel.init()
        model.date = json["date"].stringValue
        model.type = json["type"].intValue
        model.image = json["image"].stringValue
        model.address = json["address"].stringValue
        model.ip = json["ip"].stringValue
        model.status = json["status"].intValue
        
        
        return model
    }

}
