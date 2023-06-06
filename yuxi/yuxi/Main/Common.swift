//
//  Common.swift
//  Sheng
//
//  Created by DS on 2017/7/10.
//  Copyright © 2017年 First Cloud. All rights reserved.
//

/*
 宏定义
 */

import UIKit
// MARK: - 沙盒路径
let YUXIPATH_OF_CACHE = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
let YUXIPATH_OF_DOCUMENT = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
let YUXIPATH_OF_LIBRARY = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]

/// MARK: - 项目存储路径
let downLoadFile = YUXIPATH_OF_DOCUMENT + "/DownLoad"
let JSONAniFilePath = "/Animation"
let wifiSongFile = YUXIPATH_OF_DOCUMENT + "/ComputerSongs"
let copyManagerFile = YUXIPATH_OF_DOCUMENT + "/copyManager"

// MARK: - 尺寸相关
/// 屏幕分辨率
let YUXIScreen_Scale = UIScreen.main.scale

//屏幕宽高
let YUXISCREEN_WIDTH = UIScreen.main.bounds.width
let YUXISCREEN_HEIGHT = UIScreen.main.bounds.height

/// 是否是刘海屏
let YUXIISHairHead = (YUXIISIPHONEX || YUXIISIPHONEXR || YUXIISIPHONE13)
/// 是否是414的宽屏
let IS414SWidth = (YUXIISIPHONE6p || YUXIISIPHONEXR)

//状态栏高度 44.0 20.0
let YUXISTATUSBAR_HEIGHT:CGFloat = YUXIISHairHead ? 44.0:20.0//UIApplication.shared.statusBarFrame.size.height
//系统导航条高度
let YUXINavbarHeight:CGFloat = 44.0
/// 导航栏高度(导航条和状态栏总高度)
let YUXINEWNAVHEIGHT = (YUXISTATUSBAR_HEIGHT + YUXINavbarHeight)
// Tabbar高度
let YUXITabbarHeight:CGFloat = 49.0 + YUXIIPHONEX_BH
// iPhone X底部多余的高度
let YUXIIPHONEX_BH:CGFloat = YUXIISHairHead ? 34.0:0.0
/// 是否是指定尺寸的IPHONE
let YUXIISIPHONE4 = (YUXISCREEN_WIDTH == 320.0 && YUXISCREEN_HEIGHT == 480.0)
let YUXIISIPHONE5 = (YUXISCREEN_WIDTH == 320.0 && YUXISCREEN_HEIGHT == 568.0)
let YUXIISIPHONE6 = (YUXISCREEN_WIDTH == 375.0 && YUXISCREEN_HEIGHT == 667.0)
let YUXIISIPHONE6p = (YUXISCREEN_WIDTH == 414.0 && YUXISCREEN_HEIGHT == 736.0)
let YUXIISIPHONEX = (YUXISCREEN_WIDTH == 375.0 && YUXISCREEN_HEIGHT == 812.0)  //X,XS
let YUXIISIPHONEXR = (YUXISCREEN_WIDTH == 414.0 && YUXISCREEN_HEIGHT == 896.0)  //XR XSMAX
let YUXIISIPHONE13 = (YUXISCREEN_WIDTH == 390.0 && YUXISCREEN_HEIGHT == 844.0)

/// 比例
let YUXIIPONE_SCALE: Float = (YUXIISIPHONE6p || YUXIISIPHONEXR) ? (414.0/375.0):((YUXIISIPHONE6||YUXIISIPHONEX) ? 1.0:(320.0/375.0))  //手机屏宽的比例
let isIphoneHair_scaleH: Float = (YUXIISIPHONEX ? (812.0/667.0) : (YUXIISIPHONEXR ? (896.0/667.0) : 1.0))
let YUXIIPONE_SCALEH: Float = YUXIISIPHONE4 ? (480.0/667.0) : (YUXIISIPHONE5 ? (568.0/667.0) : (YUXIISIPHONE6 ? 1.0 : (YUXIISIPHONE6p ? (736.0/667.0) : isIphoneHair_scaleH)))

/// 宽高比例 以iPhone6为基准
func WIDTH_SCALE(_ width:Float) -> CGFloat {
    return CGFloat(width * YUXIIPONE_SCALE)
}

///相关主题色
let YUXIRed_Color:UIColor = YUXICOLOR(h: 0x00A2FF, alpha: 1)

let TitleWhite_Color = YUXICOLOR(h: 0xF7F6FF, alpha: 1)

// MARK: - 版本号相关
/// App版本号
let YUXIAPP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let YUXIBUNDLE_VERSION = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
/// 系统版本
let IOS_VERSION = UIDevice.current.systemVersion._bridgeToObjectiveC().doubleValue

// MARK: - 系统相关
//是否是真机
func ISIPHONE() -> Bool {
    #if TARGET_OS_IPHONE
        return true
    #endif
    #if TARGET_IPHONE_SIMULATOR
        return false
    #endif
    return false
}

// MARK: - 颜色相关
//根据十六进制数生成颜色 YUXICOLOR(h:0xe6e6e6,alpha:0.8)
func YUXICOLOR(h:Int,alpha:CGFloat) ->UIColor {
    return YUXIRGBCOLOR(r: CGFloat(((h)>>16) & 0xFF), g:   CGFloat(((h)>>8) & 0xFF), b:  CGFloat((h) & 0xFF),alpha: alpha)
}
//根据R,G,B生成颜色
func YUXIRGBCOLOR(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
//随机色
func RANDOMCOLOR() -> UIColor {
    return YUXIRGBCOLOR(r: CGFloat(arc4random()%256), g: CGFloat(arc4random()%256), b: CGFloat(arc4random()%256),alpha: 1)
}

//跳转到登录页面 - 带返回按钮的
//func jumpToLoginPage(_ isShowSanYanLogin:Bool = true) {
//
//    let controller = UIViewController.YUXIgetCurrentViewCtrl()
//    if controller is YUXILoginAccountController {
//        return
//    }
//
//    Tools.showNewLoginViewControllerWith(navBack: false, ableQuick: false, window: UIApplication.shared.keyWindow)
////    let vc = NewLoginMainController()
////    vc.isRegisted = false
////    vc.isShowSanYanLogin = isShowSanYanLogin
////    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//}

//func GETCHECKSTATE() -> Bool{
//    return UserDefaults.standard.integer(forKey: SNavBarSwitch) == 0
//}

func IPHONESEC(_ num:CGFloat)->CGFloat{
    return num*CGFloat(YUXIIPONE_SCALE)
}
let dataCount = 20
// MARK: - 字体相关
let Default_Font = "PingFangSC-Regular"

// MARK: - DEBUG模式下打印(Swift)
func Dprint(filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print("class:" + fileName + "  line:" + "\(rowCount)" + "\n")
    #endif
}
func Dprint<T>(_ message: T, filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print("class:" + fileName + "  line:" + "\(rowCount)" + "  \(message)" + "\n")
    #endif
}

//MARK: - 延迟加载
typealias Task = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (()->Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

func cancel(_ task: Task?) {
    task?(true)
}

func synchronized(_ lockObj: Any, _ closure: ()->()){
    objc_sync_enter(lockObj)
    closure()
    objc_sync_exit(lockObj)
}

//点击事件埋点结构体
//enum MOB_CLICK_EVENT:String {
//    case FindRoomTab = "17"   //找房间TAB点击
//    case FindRoomListEnterRoom = "18"  //找房间列表点击进入聊天室
//    case FindRoomListPlay = "19"   //找房间列表点击播放
//    case RoomTabTogetherPlay = "20"    //房间TAB中的一起玩点击
//    case RoomTabOneToOneRoom = "21"    //房间TAB中的1V1房间点击
//    case RoomTabEnterMyRoom = "22"  //房间TAB中进入我的房间点击
//    case MessageTabSystemMsg = "23"   //消息TAB中的系统消息点击
//    case ContactTab = "24"    //联系人TAB点击
//    case ContactTabNewFriend = "25"   //联系人TAB中新的朋友点击
//    case ContactTabAttentionTab = "26"     //联系人TAB中关注TAB点击
//    case ContactTabCpTab = "27"     //联系人TAB中CPTAB点击
//    case HomepageSound = "28"     //个人主页声鉴点击
//    case BottomNavBarCenterIcon = "29"    //底部导航栏中间icon点击
//    case FindFriendTab = "30"     //找朋友TAB点击
//    case FindFriendOpenCp = "31"     //找朋友页面开启CP点击
//}

