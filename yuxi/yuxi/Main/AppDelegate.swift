//
//  AppDelegate.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/28.
//

import UIKit
import SwiftyJSON
import MagicalRecord
import AMapFoundationKit
import AMapLocationKit

//import JPush


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
//    var viewController: UINavigationController?
    
    var isSupportHorScreen:Bool = false
    
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        loadThirdSDK()
        return true
    }
    
    

    /// 加载三方sdk
    func loadThirdSDK(){
        /* 初始化SDK开始 */
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "yuxi.sqlite")
        
        AMapServices.shared().apiKey = "a6bdbb289cc7751a8b6d2dde7e86718b"
        AMapLocationManager.updatePrivacyAgree(.didAgree)
        AMapLocationManager.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        
        let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
        //监听回调事件
        center.delegate = self
        //iOS 10 使用以下方法注册，才能得到授权
        center.requestAuthorization { granted, error in
            
        }
        //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
        center.getNotificationSettings { settings in
            
        }
        
//                                                                (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound))
        
        
//        [AMapServices sharedServices].apiKey = @"您的Key";
        
//        let mgr = LocationManager.sharedInstance
//        mgr.config()
//        
//        
//        let manager = FileManager.default
//        if !manager.fileExists(atPath: downLoadFile) {
//            try! manager.createDirectory(atPath: downLoadFile, withIntermediateDirectories: true, attributes: nil)
//        }
//        FileManager.createDirectory(directoryPath: JSONAniFilePath)
//        if !manager.fileExists(atPath: copyManagerFile) {
//            try! manager.createDirectory(atPath: copyManagerFile, withIntermediateDirectories: true, attributes: nil)
//        }
//        //初始化 MagicalRecord
//        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "Sheng.sqlite")
        
        //初始化深度链接
//        let linkedme = LinkedME.getInstance()
//        linkedme?.initSession(launchOptions: launchOptions, automaticallyDisplayDeepLinkController: false, deepLinkHandler: { (bkyparams, error) in
//            if error == nil {
//                if let controlDict = bkyparams!["$control"] as? [String: Any] {
//                    if let username = controlDict["username"] {
//                        UserDefaults.BKYLinkedValue.set(value: "\(username)", forKey: .username)
//                    }z
//                }
//            }else {
//                Dprint(error)
//            }
//        })
//
       
//        let WebPCoder = SDImageWebPCoder.shared
//        SDImageCodersManager.shared.addCoder(WebPCoder)
//
//        SDWebImageDownloader.shared.setValue("image/webp,image/*,*/*;q=0.8", forHTTPHeaderField:"Accept")
        
        //设置主窗体背景色
        if let window = window {
//            window.backgroundColor = UIColor.white

//            if #available(iOS 13.0, *) {w
                window.overrideUserInterfaceStyle = .light
//            } else {
//                // Fallback on earlier versions
//            }
//            window.windowScene?.statusBarManager?.statusBarStyle = .lightContent
        }
//        UIApplication.shared.statusBarManager?.statusBarStyle = .lightContent
//        DispatchQueue.main.asyncAfter(deadline: 1) {
            self.delayLoadSDK()
//        }
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func delayLoadSDK(){
        //注册并登陆网易云信
//        BKYNIMManager.nimManagerRegister()
//         if #available(iOS 13.0, *) {
//             let style = UITraitCollection.current.userInterfaceStyle
//             QMPushManager.share().isStyle = style == .dark
//         }
         
//             WXApi.registerApp(APPID_WECHAT, universalLink: "https://files.dongdnet.com/weixin/")
        
//        let config = BuglyConfig()
//        config.debugMode = true
//        config.channel = "Bugly"
//        config.consolelogEnable = true
//        config.viewControllerTrackingEnable = true
//        config.reportLogLevel = BuglyLogLevel.warn
//        config.crashAbortTimeout = 3
//
//        Bugly.start(withAppId: APPID_BUGLY, config: config)
//
//        Bugly.setUserIdentifier(UIDevice.current.name)
//        Bugly.setUserValue(ProcessInfo.processInfo.processName, forKey: "Process")
//
//
//         // 初始化火山统计
//         let BDconfig = BDAutoTrackConfig(appID: HS_APP_ID)
//         // 设置渠道，iOS一般默认App Store渠道
//         BDconfig.channel = "App Store"
//         // 设置数据上送地址
//         BDconfig.serviceVendor = BDAutoTrackServiceVendor.CN
//         BDconfig.autoTrackEnabled = true // 全埋点开关，true开启，false关闭
//         BDconfig.showDebugLog = true//false // true:开启日志，需要参考4.3设置Logger，false:关闭日志
//         BDconfig.logNeedEncrypt = true // 加密开关，true开启，false关闭
//         BDAutoTrack.start(with: BDconfig)
         
         //初始化键盘管理对象
//         IQKeyboardManager.shared.enable = true
//         IQKeyboardManager.shared.enableAutoToolbar = false
         
         //友盟分析
//         UMSDKMothed()
 //         self.registerAPNS()
         //腾讯信鸽
 //        XGPush.startApp(ACCESS_ID_XG_LITE_VALUE, appKey: ACCESS_KEY_XG_LITE_VALUE)
 //        XGSetting().enableDebug(true)
 //        XGPush.isPush { (isOn) in
 //            Dprint("[Sheng] Push Is \(isOn ? "ON" : "OFF")")
 //        }
         
 //        self.perform(#selector(requestGiftList), with: self, afterDelay: 0.2)
//         self.resourceCopyManager()  //将bundle资源copy到沙盒
         
//         DispatchQueue.global().async {
//             //支持后台播放音频
//             ControlCenter.share().openBackstageControlAudio()
//         }
     
         NSSetUncaughtExceptionHandler { (exception) in
             Dprint("应用程序闪退")
             //关闭聊天室
//             if BKYPublicVModel.isRoomExist(){
//                 BKYRoomBoardObject.shared().hangView.closeBtnAction()
//                 Dprint("关闭多人聊天室")
//             }
//             if CROneToOneVModel.isRoomExist(){
//                 CROneToOneVModel.shared().hangView.closeBtnAction()
//                 Dprint("关闭一对一聊天室")
//             }
         }
         
         
         //shareSDK 分享
//         shareSDKMothed()
        startRequestCheck()
        self.perform(#selector(self.startRequestCheck), with: self, afterDelay: 0.5)

//        NotificationCenter.default.addObserver(self, selector: #selector(onRegisterSuccess), name: NSNotification.Name(rawValue: BDAutoTrackNotificationRegisterSuccess), object: nil)
//        activateApp()
        
    }
    @objc func startRequestCheck(){
        //启动跳转
//        if UserInfo.mr_findFirst()?.ssId != nil {
//            //            Dprint(UserInfo.mr_findFirst()?.infoComplete)
//
//            //            if UserInfo.mr_findFirst()?.infoComplete == 1 {
//            if let BKYModel =  UserInfo.mr_findFirst(){
//                BKYNIMManager.nimManagerLogin(BKYModel, completion: { (loginSuc,code) in
//                    if loginSuc{
//                        self.perform(#selector(self.loginAccount), with: self, afterDelay: 0.2)
//                    }else{
//
//                        //登录界面
//                        self.showLoginViewControllerWith(navBack: true, ableQuick: false)
//                    }
//                })
//            }else{
//
//                //登录界面
//                self.showLoginViewControllerWith(navBack: true, ableQuick: false)
//            }
//        }else{
            if UserDefaults.standard.string(forKey: "isOnKick") == nil {
                
                self.showLoginViewControllerWith(navBack: true, ableQuick: false)
            }else {
//                if FLUserDefaultsBoolGet(key: "isOnKick") == true {//推出登陆时会设置 isOnKick = true
//
//                    self.showLoginViewControllerWith(navBack: true, ableQuick: false)
//                }else {
                    
                    
                    self.showLoginViewControllerWith(navBack: true, ableQuick: false)
                    
                    
//                }
            }
//        }
        
        
//        //获取聊天室版本号
//        BKYMainTabBarController.requestChatRoomVersion()
//        //获取垃圾词列表
//        BKYRequestObject.shared.requestBadWordList()
//        //获取删除垃圾词列表
//        BKYRequestObject.shared.requestBadWordDelList()
//
//        //获取VIP等级颜色
//        BKYRequestObject.shared.requestVIPColors()
        
        //        if (launchOptions != nil) {
        //            if let data:[AnyHashable : Any] = launchOptions![UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable : Any]{
        //                self.enterActivityCRoom(data: data)
        //            }
        //        }
        //初始化百度定位
        //        BMKLocationHelper.initBMKLocation(Int64(BKYCHANNEL_ID))
//        PayModel.shared.findLocalReceiptAndSeverVerify()
        
        
        /// 腾讯统计
        //        MTA.start(withAppkey: "1109437898")
        
        
        /// 转化行为上报
//        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        Dprint(idfa)
//        let report = idfa
//        self.unionReport(report:report,device_type:"iOS", conv_type:"APP_ACTIVE")
        //        checkUrlIsAlive()
        
//        self.requestAPPVersion()
        //心跳
//        userHeartAction()
//        onlineTimerStatus()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Dprint("应用程序被杀死")
//        QMConnect.logout()

        /// APP异常退出 isExitApp设为nil
//        BKYPublicVModel.shared.isExitApp = true
        
//        Tools.leaveHeaderLineRoom()
        // 关闭定时器
//        onlineTimer?.cancel()
//        onlineTimer = nil
//
//        MagicalRecord.cleanUp()
    }
    
    /**
     收到静默推送的回调
     @param application  UIApplication 实例
     @param userInfo 推送时指定的参数
     @param completionHandler 完成回调
     */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //重设App图标未读数123
//        _ = AppDelegate.resetAppIconBageNumber()
        if UIApplication.shared.applicationState == .inactive {  //点击远程通知消息启动应用
//            self.receivedNimNotificationResponse(userInfo: userInfo)
        }
        _ = "APNs notify: \(userInfo)"
        
//        XGPush.handleReceiveNotification(userInfo, successCallback: {() in
//            if application.applicationState == .inactive{ //点击远程通知消息启动应用
//                self.enterActivityCRoom(data: userInfo)
//            }
//            self.userNoticeData(data: userInfo, isClick: false)
//        }, errorCallback: {() in
//            Dprint("[Sheng] Handle receive error22222")
//        })
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        let windowCount = UIApplication.shared.windows.count
        if isSupportHorScreen && (windowCount >= 2){
            return .landscapeRight  //home键在右边
        }else{
            return .portrait
        }
    }
    
    
    
    
    @objc func showLoginViewControllerWith(navBack: Bool, ableQuick: Bool) {
       
        //登录界面
        let newLoginV = YUXILoginAccountController.init()
//         newLoginV.hidesBottomBarWhenPushed = true
//        newLoginV.ableQuickLogin = ableQuick
        
        let nav = UINavigationController.init(rootViewController: newLoginV)
        self.window?.rootViewController = nav
        
//        UIViewController.BKYgetCurrentViewCtrl().navigationController?.pushViewController(newLoginV, animated: true)
    }
    // MARK: - Core Data stack
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Sheng")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            // Fallback on earlier versions
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch {
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
        }
        
    }
    
    // MARK: - Core Data Fallback on earlier versions
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "coreDataTestForPreOS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

}

