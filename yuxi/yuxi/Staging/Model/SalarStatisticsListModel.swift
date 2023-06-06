//
//  SalarStatisticsListModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/17.
//

import UIKit
import SwiftyJSON

class SalarStatisticsListModel: NSObject {

    //薪资
    var month:[String] = []
    
    var list:[Int] = []
    
    var unit:String = ""
    
    var sum:Float = 0.0
    
    class func getUserdepData(json: JSON) -> SalarStatisticsListModel{
        let model = SalarStatisticsListModel.init()
        model.unit = json["unit"].stringValue
        model.sum = json["sum"].floatValue
        for item in json["month"].arrayValue {
            model.month.append(item.stringValue)
        }
        for item in json["list"].arrayValue {
            model.list.append(item.intValue)
        }
        return model
    }
    
}

