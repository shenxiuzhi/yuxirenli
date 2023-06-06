//
//  MySalaryDetailsModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/17.
//

import UIKit
import SwiftyJSON

class MySalaryDetailsModel: NSObject {

    // 岗位绩效
    var gwjx_value:String = ""
    
    var jb_value:String = ""
    
    var xl_value:String = ""
    
    var gl_value:String = ""
    
    var duty_value:String = ""
    
    var rj_value:String = ""
    
    var zb_value:String = ""
    
    var yb_value:String = ""
    
    var tqbt:String = ""
    
    var holiday_value:String = ""
    
    var driver_value:String = ""
    
    var tzb_value:String = ""
    
    var zc_value:String = ""
    
    var mtk_value:String = ""
    
    var qt_value:String = ""
    
    var aqzh_value:String = ""
    
    var wsfx_value:String = ""
    
    var y_count:String = ""
    
    var per1:String = ""
    
    var per2:String = ""
    
    var per3:String = ""
    
    var per4:String = ""
    
    var per11:String = ""
    
    var per12:String = ""
    
    var sb_count:String = ""
    
    var deduct_sum:String = ""
    
    var s_count:String = ""
    
    var bonus_value:String = ""
    
    var bzz_value:String = ""
    
    class func getUserdepData(json: JSON) -> MySalaryDetailsModel{
        let model = MySalaryDetailsModel.init()
        model.gwjx_value = json["gwjx_value"].stringValue
        model.jb_value = json["jb_value"].stringValue
        model.xl_value = json["xl_value"].stringValue
        model.gl_value = json["gl_value"].stringValue
        model.duty_value = json["duty_value"].stringValue
        model.rj_value = json["rj_value"].stringValue
        model.zb_value = json["zb_value"].stringValue
        model.yb_value = json["yb_value"].stringValue
        model.tqbt = json["tqbt"].stringValue
        model.holiday_value = json["holiday_value"].stringValue
        model.driver_value = json["driver_value"].stringValue
        model.tzb_value = json["tzb_value"].stringValue
        model.zc_value = json["zc_value"].stringValue
        model.mtk_value = json["mtk_value"].stringValue
        model.qt_value = json["qt_value"].stringValue
        model.aqzh_value = json["aqzh_value"].stringValue
        model.wsfx_value = json["wsfx_value"].stringValue
        model.y_count = json["y_count"].stringValue
        model.per1 = json["per1"].stringValue
        model.per2 = json["per2"].stringValue
        model.per3 = json["per3"].stringValue
        model.per4 = json["per4"].stringValue
        model.per11 = json["per11"].stringValue
        model.per12 = json["per12"].stringValue
        model.sb_count = json["sb_count"].stringValue
        model.deduct_sum = json["deduct_sum"].stringValue
        model.s_count = json["s_count"].stringValue
        model.bonus_value = json["bonus_value"].stringValue
        model.bzz_value = json["bzz_value"].stringValue
        return model
    }
    
}
