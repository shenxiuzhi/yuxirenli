//
//  UserDefaultsEx.swift
//  Sheng
//
//  Created by DS on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

// MARK: - UserDefaults类扩展
extension UserDefaults{
    
    /// 聊天室相关KEY
    struct ChatRoom: UserDefaultsSettable {
        enum defaultKeys: String {
            case shareMusicArr          //音乐分享列表数组
            case hbArr
            case vipColDicArr            //VIP等级颜色数组
        }
    }
    
    /// 位置相关KEY
    struct LBSNear: UserDefaultsSettable {
        enum defaultKeys: String {
            case updateLocationDate  //地理位置更新时间
            case longitude   //经度
            case latitude   //纬度
        }
    }
    
    /// 抢单中心相关KEY
    struct RobOrder: UserDefaultsSettable {
        enum defaultKeys:String {
            case robOrderReadTime  //读取消息的时间
        }
    }
    
    /// 派单中心相关KEY
    struct AssignOrder: UserDefaultsSettable {
        enum defaultKeys:String {
            case readTime  //读取消息的时间
            case pushState //用户设置关闭推送  1_开启/推送 2_关闭/不推送
        }
    }
    
    /// 动态相关KEY
    struct DynamicModule: UserDefaultsSettable {
        enum defaultKeys:String {
            case lastDynamicTagID  //上次点击的动态分类ID
        }
    }
    
    /// 开屏广告相关KEY
    struct LaunchAd: UserDefaultsSettable {
        enum defaultKeys:String {
            case showLaunchAdDate  //开屏广告展示时间
            case launchAdModelDic  //开屏动画缓存数据
        }
    }
    
    /// 积分任务相关KEY
    struct OnlineTime: UserDefaultsSettable {
        enum defaultKeys:String {
            case lastTextDateDic        //房间里上次发消息的时间字典
            case onlineTimeUpdateDate  //上次更新在线时长的时间
            case onlineTimeSecondDic  //今日在线秒数字典
            case welfareOnlineTime   //福利专区累计时长
        }
    }
    /// 首充提示相关KEY
    struct RewardAlert: UserDefaultsSettable {
        enum defaultKeys: String {
            case alertRewardDate  //首充奖励提醒时间
        }
    }
    
    /// 青少年模式相关KEY
    struct TeenagerMode: UserDefaultsSettable {
        enum defaultKeys: String {
            case alertTeenModeDate  //青少年模式提醒时间
        }
    }
    
    /// 开启/关闭系统消息通知相关KEY
    struct SysNofMode: UserDefaultsSettable {
        enum defaultKeys: String {
            case sysNofType
        }
    }
    
    /// 消费消息通知相关KEY
    struct TipsAlertMode: UserDefaultsSettable {
        enum defaultKeys: String {
            case soulMarchType /// 灵魂匹配提升
            case skyBottleType /// 星空漂流瓶提升

        }
    }
    
    /// 服务条例相关KEY
    struct ServiceTerms: UserDefaultsSettable {
        enum defaultKeys: String {
            case isAgreeServiceTerms  //是否同意服务条例
        }
    }
    /// 实名认证相关KEY
    struct RealNameAuth: UserDefaultsSettable {
        enum defaultKeys: String {
            case isRealNameAuth  //是否需要实名认证
        }
    }
    /// 砸蛋设置相关KEY
    struct JDSwitchState: UserDefaultsSettable {
        enum defaultKeys: String {
            case isNoNotify  //对外提示中奖信息的状态 1：开  2：关  （默认开）
            case onlyMyInfo  //只显示自己的砸蛋信息
            case newVersion  //砸蛋上新版本
            case autoSmash   //是否为首次缩小自动砸蛋
            case autoSmashBox  //是否为首次缩小自动开箱子
        }
    }
    /// 发动态相关KEY
    struct PublishGuideState: UserDefaultsSettable {
        enum defaultKeys: String {
            case hasPublishGuide  //是否需要引导发动态
        }
    }
    
    /// 用户登录信息记录
    struct LocalAccounts: UserDefaultsSettable {
        enum defaultKeys: String {
            case SaveLocalAccounts          //音乐分享列表数组
            case NewUserGreetingDic           //新用户打招呼字典
        }
    }
    
    
    struct TabbarInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case imageUrlNormal   //未选中图片
            case imageUrlSelect  //选中图片
            case tabName  //名称
            case sort     //序号
        }
    }
    
    //    struct AppStore: UserDefaultsSettable {
    //        enum defaultKeys:String {
    //            case receiptDic        //需要服务器校验的票据Key
    //        }
    //    }
    
    /// 首次查看邂逅滑动查看更多
    struct KEEncounterMoreState: UserDefaultsSettable {
        enum defaultKeys: String {
            case encounterMoreState
        }
    }
    
    /// 漂流瓶开关状态
    struct KEDriftingBottleState: UserDefaultsSettable {
        enum defaultKeys: String {
            case driftingBottleState
        }
    }
    
}

protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    static func set(value: String?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func string(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
    static func set(value: [Any]?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func array(forKey key: defaultKeys) -> [Any]? {
        let aKey = key.rawValue
        return UserDefaults.standard.array(forKey: aKey)
    }
    
    static func set(value: [String:Any]?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func dictionary(forKey key: defaultKeys) -> [String:Any]? {
        let aKey = key.rawValue
        return UserDefaults.standard.dictionary(forKey: aKey)
    }
    
    static func deleteArr(forKey key:defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.removeObject(forKey: aKey)
    }
}

@objc class UserHelper: NSObject {
    //今天是否已更新位置信息
//    static func hasUpdateLocationDateToday() -> Bool {
//        let dateStr = UserDefaults.LBSNear.string(forKey: .updateLocationDate)
//        return dateStr == Tools.getTodayYearMonthDayStr() ? true : false //判断时间是否相同
//    }
    
    //更新位置信息之后保存日期
    static func setUpdateLocationTime(){
//        UserDefaults.LBSNear.set(value: Tools.getTodayYearMonthDayStr(), forKey: .updateLocationDate)
    }
    
    
    
    //是否已同意服务条例
    @objc static func hasAgreeServiceTerms() -> Bool {
        return nil != UserDefaults.ServiceTerms.string(forKey: .isAgreeServiceTerms) ? true : false //判断时间是否相同
    }
    //同意服务条例后保存
    static func setServiceTerms(){
        UserDefaults.ServiceTerms.set(value: "true", forKey: .isAgreeServiceTerms)
    }
    
    
    
    /// 是否需要实名认证
    /// - Returns: true - 已验证  false - 未验证
    static func hasRealNameAuth() -> Bool {
        return (UserDefaults.RealNameAuth.string(forKey: .isRealNameAuth) == "true") ? true : false
    }
    
    /// 是否首次缩小自动砸蛋
    /// - Returns: true - 已验证  false - 未验证
    static func hasAlertAutoSmash() -> Bool {
        return (UserDefaults.JDSwitchState.string(forKey: .autoSmash) == "true") ? true : false
    }
    
    /// 是否首次展示邂逅滑动展示更多
    /// - Returns: true - 已验证  false - 未验证
    static func hasAlertFirEncounterMore() -> Bool {
        return (UserDefaults.KEEncounterMoreState.string(forKey: .encounterMoreState) == "true") ? true : false
    }
    /// 保存首次展示邂逅滑动展示更多
    static func setFirEncounterMore(_ str : String) {
        UserDefaults.KEEncounterMoreState.set(value: str, forKey: .encounterMoreState)
    }
    
    
    /// 是否首次缩小自动开箱子
    /// - Returns: true - 已验证  false - 未验证
    static func hasAlertAutoSmashBox() -> Bool {
        return (UserDefaults.JDSwitchState.string(forKey: .autoSmashBox) == "true") ? true : false
    }
    
    ///实名认证后保存
    static func setRealNameAuth(_ str : String){
        UserDefaults.RealNameAuth.set(value: str, forKey: .isRealNameAuth)
    }
    ///保存砸蛋设置状态
    static func setJDOnlyMyInfo(_ str : String){
        UserDefaults.JDSwitchState.set(value: str, forKey: .onlyMyInfo)
    }
    static func setJDIsNoNotify(_ str : String){
        UserDefaults.JDSwitchState.set(value: str, forKey: .isNoNotify)
    }
    /// 保存砸蛋上新版本
    static func setJDNewVersion(_ str : String){
        UserDefaults.JDSwitchState.set(value: str, forKey: .newVersion)
    }
    
    /// 保存首次自动砸蛋
    static func setJDAutoSmash(_ str : String){
        UserDefaults.JDSwitchState.set(value: str, forKey: .autoSmash)
    }
    
    /// 保存首次自动砸蛋
    static func setJDAutoSmashBox(_ str : String){
        UserDefaults.JDSwitchState.set(value: str, forKey: .autoSmashBox)
    }
    
    
    
    /// 是否需要发动态引导
    /// - Returns: true - 需要  false - 不需要
    static func hasPublishGuide() -> Bool {
        return (UserDefaults.PublishGuideState.string(forKey: .hasPublishGuide) == "false") ? false : true
    }
    ///发动态引导后保存
    static func setPublishGuide(_ str : String){
        UserDefaults.PublishGuideState.set(value: str, forKey: .hasPublishGuide)
    }
    
    /// 获取上次删除关键字id
    static func lastDelKeyWordId() -> Int {
        let defaults = UserDefaults()
        let userTimeKey = "lastDelKeyWordId" + YUXIAPP_VERSION
        let dateStr = defaults.object(forKey: userTimeKey) as? Int
        return dateStr == nil ? 0 : dateStr! //判断时间是否相同
    }
    
    /// 保存上次删除关键字id
    static func setlastDelKeyWordId(id:Int) {
        let defaults = UserDefaults()
        let userTimeKey = "lastDelKeyWordId" + YUXIAPP_VERSION
        defaults.set(id, forKey: userTimeKey)
        defaults.synchronize()
    }
    
    
    
}
