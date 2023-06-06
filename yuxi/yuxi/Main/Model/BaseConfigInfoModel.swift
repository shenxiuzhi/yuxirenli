//
//  BaseConfigInfoModel.swift
//  Sheng
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseConfigInfoModel: NSObject {
    var dictCode: String = ""
    var dictDesc: String = ""
    var dictName: String = ""
    var dictValue: String = ""
    var sort: Int = 0

    class func getModelFrom(json: JSON) -> BaseConfigInfoModel {
        let model = BaseConfigInfoModel.init()
        model.dictCode = json["dictCode"].stringValue
        model.dictDesc = json["dictDesc"].stringValue
        model.dictName = json["dictName"].stringValue
        model.dictValue = json["dictValue"].stringValue
        model.sort = json["sort"].intValue
        return model
    }
    
    func dictionaryFromModel() -> [String:Any]{
        var modelDic:[String:Any] = [:]
        modelDic["dictCode"] = self.dictCode
        modelDic["dictDesc"] = self.dictDesc
        modelDic["dictName"] = self.dictName
        modelDic["dictValue"] = self.dictValue
        modelDic["sort"] = self.sort
        return modelDic
    }
}
