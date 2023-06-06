//
//  PersonalInformationPageModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/29.
//

import UIKit
import SwiftyJSON

class PersonalInformationPageModel: NSObject {

    var username:String = ""
    
    var department:String = ""
    
    var position:String = ""
    
    var email:String = ""
    
    var phone:String = ""
    
    var work_age:String = ""
    
    var entry_date:String = ""
    
    class func getUserdepData(json: JSON) -> PersonalInformationPageModel{
        let model = PersonalInformationPageModel.init()
        model.username = json["username"].stringValue
        model.department = json["department"].stringValue
        model.position = json["position"].stringValue
        model.email = json["email"].stringValue
        model.phone = json["phone"].stringValue
        model.work_age = json["work_age"].stringValue
        model.entry_date = json["entry_date"].stringValue
        return model
    }
    
}
