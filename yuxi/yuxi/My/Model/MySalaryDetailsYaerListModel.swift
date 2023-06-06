//
//  MySalaryDetailsYaerListModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/17.
//

import UIKit
import SwiftyJSON

class MySalaryDetailsYaerListModel: NSObject {
    //发放日期
    var salary_date:Int64 = 0
    //更新时间
    var update_time:String = ""
    //实领工资
    var s_count:String = ""
    //员工编码
    var u_code:String = ""
    //台账id
    var book_id:Int64 = 0
    //
    var month:String = ""
    
    class func getUserdepData(json: JSON) -> MySalaryDetailsYaerListModel{
        let model = MySalaryDetailsYaerListModel.init()
        model.salary_date = json["salary_date"].int64Value
        model.update_time = json["update_time"].stringValue
        model.s_count = json["s_count"].stringValue
        model.u_code = json["u_code"].stringValue
        model.book_id = json["book_id"].int64Value
        model.month = json["month"].stringValue
        return model
    }
}
