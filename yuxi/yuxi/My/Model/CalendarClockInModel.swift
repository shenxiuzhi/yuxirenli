//
//  CalendarClockInModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/19.
//

import UIKit
import SwiftyJSON

class CalendarClockInModel: NSObject {
    
    var indexWorkDayOfMonth:Int64 = 0
    var date:String = ""
    var lunarCalendar:String = ""
    var constellation = ""
    var dayOfYear:Int64 = 0
    var type:Int64 = 0
    var status:String = ""//是否异常,0:异常,1:正常
    var month:String = ""
    var year:String = ""
    var yearTips:String = ""
    var suit:String = ""
    var solarTerms:String = ""
    var chineseZodiac:String = ""
    var weekDay:String = ""
    var ID:Int64 = 0
    var weekOfYear:Int64 = 0
    var typeDes:String = ""
    var day:String = ""
    
    var need:String = ""//是否需要打卡,0:不需要,1需要
    
    class func getUserdepData(json: JSON) -> CalendarClockInModel{
        let model = CalendarClockInModel.init()
        model.indexWorkDayOfMonth = json["indexWorkDayOfMonth"].int64Value
        model.date = json["date"].stringValue
        model.lunarCalendar = json["lunarCalendar"].stringValue
        model.constellation = json["constellation"].stringValue
        model.dayOfYear = json["dayOfYear"].int64Value
        model.type = json["type"].int64Value
        model.status = json["status"].stringValue
        model.month = json["month"].stringValue
        model.year = json["year"].stringValue
        model.yearTips = json["yearTips"].stringValue
        model.suit = json["suit"].stringValue
        model.solarTerms = json["solarTerms"].stringValue
        model.chineseZodiac = json["chineseZodiac"].stringValue
        model.weekDay = json["weekDay"].stringValue
        model.ID = json["id"].int64Value
        model.weekOfYear = json["weekOfYear"].int64Value
        model.typeDes = json["typeDes"].stringValue
        model.day = json["day"].stringValue
        model.need = json["need"].stringValue
        return model
    }
}
