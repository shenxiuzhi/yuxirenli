//
//  SURLMacro.swift
//  Sheng
//
//  Created by DS on 2017/7/12.
//  Copyright © 2017年 mac. All rights reserved.
//

/*
 URL管理类
 */

import Foundation

// MARK: - BASE
/// 渠道号  60380000-正式 60990000-企业版（如果增加一个渠道号，SCHANNEL_ID，is_no_qiye_version，UMCHANNELID，都需要做检查）
let SCHANNEL_ID = 60380000

///后台服务器类别：0:正式服务器 1:备份服务器 2:预发布环境。
let appServerType = 1

let is_no_qiye_version:Bool = (SCHANNEL_ID == 60380000) //非企业版（true）;企业版（false）

//友盟统计渠道号
//let UMCHANNELID = (SCHANNEL_ID == 60990000) ? "60990000 iOS 企业版" : ((SCHANNEL_ID == 60380000) ? "60380000 iOS Appstore" : "00000000 iOS 未知渠道")

/// 以下开关对应的版本号（每次发版本必须检查）
let activitiesIsOnVersion:String = "1.000"

let activitiesExamineCode = 00039

/// 项目编号
let appID = 10000002

///后台本地地址（用于调试接口数据）
let PYADDRESS_URL = "http://39.98.212.241"

/// 域名
let BASE_Url = "http:/yxrlzy.cn"
//(appServerType == 1) ? "http://i.sheng.mchang.cn/api-sheng":((appServerType == 2) ? "http://preapi.kongear.cn/api-sheng":"http://i.kongear.cn/api-sheng")

/// get请求后缀
let Suffix_Get = "/json"

/// post请求后缀
let Suffix_Post = "/jform"

