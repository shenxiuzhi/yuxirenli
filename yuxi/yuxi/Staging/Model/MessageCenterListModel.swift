//
//  MessageCenterListModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/17.
//

import UIKit
import SwiftyJSON

class MessageCenterListModel: NSObject {

    var ID:Int64 = 0
    
    var title:String = ""
    
    var type:Int64 = 0
    
    var model:String = ""
    
    var u_id:Int64 = 0
    
    var a_id:String = ""
    
    var date:String = ""
    
    var status:Int64 = 0
    
    var create_time:String = ""
    
    var update_time:String = ""
    
    var delete_time:String = ""
    
    class func getUserdepData(json: JSON) -> MessageCenterListModel{
        let model = MessageCenterListModel.init()
        model.ID = json["id"].int64Value
        model.title = json["title"].stringValue
        model.type = json["type"].int64Value
        model.model = json["model"].stringValue
        model.u_id = json["u_id"].int64Value
        model.a_id = json["a_id"].stringValue
        model.date = json["date"].stringValue
        model.status = json["status"].int64Value
        model.create_time = json["create_time"].stringValue
        model.update_time = json["update_time"].stringValue
        model.delete_time = json["delete_time"].stringValue
        
        return model
    }
    
}
