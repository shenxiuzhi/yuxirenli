//
//  AddressBookModel.swift
//  yuxi
//
//  Created by 申修智 on 2023/6/1.
//

import UIKit
import SwiftyJSON

class AddressBookModel: NSObject {
    
    var json:[AddressBookModel] = []
    
    var name:String = ""
    
    var type:Int = 0
    
    var ID:Int64 = 0
    
    var tel:String = ""
    
    
    
    class func getUserdepData(json: JSON) -> AddressBookModel{
        let model = AddressBookModel.init()
        model.name = json["name"].stringValue
        model.type = json["type"].intValue
        model.ID = json["id"].int64Value
        model.tel = json["tel"].stringValue
        for item in json["json"].arrayValue{
            let model2 = AddressBookModel.getUserdepData(json:item)
            model.json.append(model2)
        }
        
        return model
    }
}


