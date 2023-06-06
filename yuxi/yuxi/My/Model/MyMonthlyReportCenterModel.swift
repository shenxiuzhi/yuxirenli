//
//  MyMonthlyReportCenterModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/29.
//

import UIKit
import SwiftyJSON

class MyMonthlyReportCenterModel: NSObject {
    
    
    var dep_code:String = ""
    
    var s_code:String = ""
    
    var should_day:String = ""
    
    var reality_day:String = ""
    
    var extra_day:String = ""
    
    var legal_day:String = ""
    
    var early_day:String = ""
    
    var middle_day:String = ""
    
    var night_day:String = ""
    
    var zt_day:String = ""
    
    var cd_day:String = ""
    
    var qq_day:String = ""
    
    
    class func getUserdepData(json: JSON) -> MyMonthlyReportCenterModel{
        let model = MyMonthlyReportCenterModel.init()
        model.dep_code = json["dep_code"].stringValue
        model.s_code = json["s_code"].stringValue
        model.should_day = json["should_day"].stringValue
        model.reality_day = json["reality_day"].stringValue
        model.extra_day = json["extra_day"].stringValue
        model.legal_day = json["legal_day"].stringValue
        model.early_day = json["early_day"].stringValue
        model.middle_day = json["middle_day"].stringValue
        model.night_day = json["night_day"].stringValue
        model.zt_day = json["zt_day"].stringValue
        model.cd_day = json["cd_day"].stringValue
        model.qq_day = json["qq_day"].stringValue
        
        return model
    }
}
