//
//  SSActivitiesStateModel.swift
//  Sheng
//
//  Created by DS on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 项目开关数据模型
class SSActivitiesStateModel: NSObject {
    
    /**
     * 编号
     */
    var code:String = ""
    
    /**
     * 状态   0 关闭     1 开启
     */
    var state:Int = 0
    
    /**
     * 版本号
     */
    var version:String = ""
    
    /**
     * 描述/标题
     */
    var des:String = ""
    
    /**
     * 副描述/副标题
     */
    var des1:String = ""
    
    /**
     * 图片url
     */
    var imageUrl:String = ""
    
    /**
     * 跳转url
     */
    var actionUrl:String = ""
    
    /**
     * 开关类型 -1_全部 0_默认 ≥1 既定跳转  11_房间声音鉴定,
     * 房间内: -1 半屏h5显示
     */
    var type:Int = 0
    
    /**
     * 'new字样是否显示     0：不显示   1：显示'
     */
    var newShow:Int = 0
    
    class func getModelFrom(json:JSON) ->SSActivitiesStateModel{
        let model = SSActivitiesStateModel.init()
        model.code = json["code"].stringValue
        model.state = json["state"].intValue
        model.version = json["version"].stringValue
        model.des = json["des"].stringValue
        model.imageUrl = json["imageUrl"].stringValue
        model.actionUrl = json["actionUrl"].stringValue
        
        model.des1 = json["des1"].stringValue
        model.type = json["type"].intValue
        model.newShow = json["newShow"].intValue
        return model
    }

}
