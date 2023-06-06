//
//  EmployeeStaisticsModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/6/1.
//

import UIKit
import SwiftyJSON

class EmployeeStaisticsModel: NSObject {
    
    
    var age:[String] = []
    
    var edu:[String] = []
    
    var spe:[String] = []
    
    var dut:[String] = []
    
    var list:[Double] = []
    
    var title:String = ""
    
    class func getUserdepData(json: JSON) -> EmployeeStaisticsModel{
        let model = EmployeeStaisticsModel.init()
        model.title = json["title"].stringValue
        for item in json["age"].arrayValue {
            model.age.append(item.stringValue)
        }
        for item in json["list"].arrayValue {
            model.list.append(item.doubleValue)
        }
        for item in json["edu"].arrayValue {
            model.edu.append(item.stringValue)
        }
        for item in json["spe"].arrayValue {
            model.spe.append(item.stringValue)
        }
        for item in json["dut"].arrayValue {
            model.dut.append(item.stringValue)
        }
        return model
    }
    
    
}
