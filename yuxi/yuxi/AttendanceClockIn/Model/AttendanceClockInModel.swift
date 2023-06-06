//
//  AttendanceClockInModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/21.
//

import UIKit
import SwiftyJSON

class AttendanceClockInModel: NSObject {
    
    //日期
    var date:String = ""
    //类型 ->长白班 1:上班；2:休假 三班倒：1、2、3 早班、中班、完成
    var type:String = ""
    //周几
    var weekDay:String = ""
    //第一次上班时间
    var starttime1:String = ""
    //第一次下班时间
    var endtime1:String = ""
    //第二次上班时间
    var starttime2:String = ""
    //第二次下班时间
    var endtime2:String = ""
    //打卡地点纬度1
    var lat:Double = 0.0
    //打卡地点经度
    var lon:Double = 0.0
    //打卡范围
    var range:Double = 0.0
    //类型->1：长白班 2：三班倒 3：两班倒
    var atttype:String = ""
    //三班倒早中晚
    var typedet:String = ""
    //两班倒早晚
    var typedetl:String = ""
    //
    var timeci:[timeciModel] = []
    //上班或下班-> 0 不再打卡时间范围 1：第一次上班打卡 2：第一次下班打卡3：第二次上班打卡 3：第二次下班打卡
    var onoroff:Int = 0
    //考勤记录id
    var infoid:String = ""
    //是否限制打卡地点 0:不限制
    var is_address:Int = 1
    
    class func getUserdepData(json: JSON) -> AttendanceClockInModel{
        var model = AttendanceClockInModel.init()
        model.date = json["date"].stringValue
        model.type = json["type"].stringValue
        model.weekDay = json["weekDay"].stringValue
        model.starttime1 = json["starttime1"].stringValue
        model.endtime1 = json["endtime1"].stringValue
        model.starttime2 = json["starttime2"].stringValue
        model.endtime2 = json["endtime2"].stringValue
        model.lat = json["lat"].doubleValue
        model.lon = json["lon"].doubleValue
        model.range = json["range"].doubleValue
        model.atttype = json["atttype"].stringValue
        model.typedet = json["typedet"].stringValue
        model.typedetl = json["typedetl"].stringValue
        for item in json["timeci"].arrayValue {
            let timeciM = timeciModel.getUserdepData(json: item)
            model.timeci.append(timeciM)
        }
        model.onoroff = json["onoroff"].intValue
        model.infoid = json["infoid"].stringValue
        model.is_address = json["is_address"].intValue
        
        return model
    }

}

class timeciModel: NSObject {

    var end:String = ""
    
    var start:String = ""
    
    class func getUserdepData(json: JSON) -> timeciModel{
        var model = timeciModel.init()
        model.start = json["start"].stringValue
        model.end = json["end"].stringValue
        return model
    }
    
}
