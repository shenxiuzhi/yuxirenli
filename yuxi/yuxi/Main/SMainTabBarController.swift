//
//  SMainTabBarController.swift
//  Sheng
//
//  Created by DS on 2019/3/4.
//  Copyright © 2019年 First Cloud. All rights reserved.
//

import UIKit
import SwiftyJSON
//import AdSupport
import YYWebImage

///  可视TabBar
class SMainTabBarController: SBaseTabBarViewController, UIGestureRecognizerDelegate {
    
    lazy var attendanceCtrlPage = {
        return AttendanceClockInViewController()
    }()
    lazy var stagingCtrl = {
        return StagingViewController()
    }()
    
    private lazy var myCtrl = {
        return MyViewController()
    }()
    
    
    
    private var isShowLightOrder = false  //闪单按钮开关
    private lazy var realNameAlert = {
//        return RealNameAlert() //实名认证弹窗
    }()
//    private lazy var serviceTermAlert = {
//        return ServiceTermAlert()   //服务条款弹窗
//    }()
    
    
    ///四个item的选中动图
    private var firstItemSelectAniImage: YYAnimatedImageView!
    private var secondItemSelectAniImage: YYAnimatedImageView!
    private var thirdItemSelectAniImage: YYAnimatedImageView!
    private var fourthItemSelectAniImage: YYAnimatedImageView!
    private var fifthItemSelectAniImage: YYAnimatedImageView!
    
    ///保存选中图片
    private var selectImagesArr: [UIImage] = [UIImage]()
    ///是否支持动画
    private var isAnimateTab: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取腾讯云BucketName
        //        SRequestObject.shared.getTencentBucketNameFunction()
//        SRequestObject.shared.getDynamicStateFunction()
        
        setUpInterface()
        addTabbarChildController()
        addNotice()
//        if let window = UIApplication.shared.keyWindow {
//            Tools.requestAPPVersion(window: window)
//        }
//        requestPasswordInfo()
//        requestServerUnreadNumberAction()
//        preLoadBecomeCoupleAnimationFile()
//        preLoadAllRoomHighBannerAniImage()
        requestSendPatFunctionSwitch(type: 51)
        self.perform(#selector(loadBadWordData), with: nil, afterDelay: 5.0)
        
        self.selectedIndex = 0
        ///
        isOpenYoung()
    }
    
    func isOpenYoung() {
//        if let loginKey = UserInfo.mr_findFirst()?.loginKey {
//            let url = String.init(format: GetJuniorsSchemaState_URL)
//            let parms = ["loginKey":loginKey] as [String : Any]
//            let checkParms = [loginKey]
//            SURLRequest.sharedInstance.requestPostWithHeader(url, param: parms, checkSum: checkParms, suc: { [weak self] (data) in
//                if let weakself = self {
//                    print("GetJuniorsSchemaState_URL \(data)")
//                    let json = JSON(data)
//                    let result = json["result"].stringValue
//                    let resultValue = json["content"].boolValue
//                    if result == "ok" {
//                        if resultValue {
//                            let youngTipController = KEYoungTipController()
//                            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(youngTipController, animated: true)
//                        }
//                    }
//                }
//                }, err: { (error) in
//                    print("API_OrderConfirm \(error)")
//            })
//        }
    }
    
    @objc func loadBadWordData(){
        
        //获取垃圾词列表
//        SRequestObject.shared.requestBadWordList()
//        //获取删除垃圾词列表
//        SRequestObject.shared.requestBadWordDelList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.interactivePopGestureRecognizer?.delegate = self  //侧滑返回
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    deinit {
        self.removeNotice()
    }
    
    // MARK: - private
    private func setUpInterface() {
        //隐藏导航
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.interactivePopGestureRecognizer?.delegate = self  //侧滑返回
        }
        
        //设置tabbar属性
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage.init(named: "clearImage")
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1.0).cgColor //HEXCOLOR(h: 0x000000, alpha: 1.0).cgColor
        self.tabBar.layer.shadowOffset = CGSize.init(width: 0, height: -2.0)
        self.tabBar.layer.shadowOpacity = 0.1
        
        self.navigationController?.navigationBar.isHidden = true
        self.delegate = self
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : YUXICOLOR(h: 0x303030, alpha: 1)], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: CGFloat(10*YUXIIPONE_SCALE))], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : YUXICOLOR(h: 0x303030, alpha: 1)], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: CGFloat(10*YUXIIPONE_SCALE))], for: .selected)
        self.tabBar.tintColor = YUXICOLOR(h: 0x303030, alpha: 1)

    }
    
    
    
//    @objc func agrementAction() {
//        let vc: WebVC = WebVC()
//        vc.loadStr = Register_Rule_URL
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @objc func privacyAction() {
//        let vc: WebVC = WebVC()
//        vc.loadStr = PrivacyPolicy_URL
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @objc private func exitApp(){
//        exit(0)
//    }
    //关闭服务条款弹窗
//    @objc private func cancelServiceAlert(){
//        UserHelper.setServiceTerms()
//        serviceTermAlert.removeFromSuperview()
//    }
    
    private func addTabbarChildController(){
        //firstCtrl.view.backgroundColor = .red
        setupOneChildViewController(attendanceCtrlPage, title: "考勤打卡", normalImage: "Tab_Attendance_nor", selectedImage: "Tab_Attendance_sel", idx: 0)
        setupOneChildViewController(stagingCtrl, title: "工作台", normalImage: "Tab_Staging_nor", selectedImage: "Tab_Staging_sel", idx: 1)
        setupOneChildViewController(myCtrl, title: "我的", normalImage: "Tab_My_nor", selectedImage: "Tab_My_sel", idx: 2)
        
//        setupChildsDynamicImages()
        getTabBarNetInfoToReset()
    }
    
    private func setupOneChildViewController(_ vc:UIViewController,title:String, normalImage:String, selectedImage:String, idx: Int){
        var modelArr: [BaseConfigInfoModel] = [BaseConfigInfoModel]()
        if let infoArr = UserDefaults.TabbarInfo.array(forKey: .imageUrlSelect) {
            for item in infoArr {
                let model = BaseConfigInfoModel.getModelFrom(json: JSON(item))
                modelArr.append(model)
            }

            if idx < modelArr.count {
                let modelM = modelArr[idx]
                let navVc = BaseNavigationController.init(rootViewController: vc)
                navVc.tabBarItem.title = title
                navVc.tabBarItem.image = UIImage.init(named: normalImage)?.withRenderingMode(.alwaysOriginal)
                navVc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
                navVc.navigationBar.isHidden = true
                setupChildViewControllerImageFromNet(navVc, title: modelM.dictDesc, normalImage: modelM.dictName, selectedImage: modelM.dictValue, placeholderNormal: normalImage, placeholderSelected: selectedImage, animateImage: modelM.dictCode)
            } else {
                let navVc = BaseNavigationController.init(rootViewController: vc)
                navVc.tabBarItem.title = title
                navVc.tabBarItem.image = UIImage.init(named: normalImage)?.withRenderingMode(.alwaysOriginal)
                navVc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
                navVc.navigationBar.isHidden = true
                self.addChild(navVc)
            }

        } else {
//            vc.tabBarItem.title = title
//            vc.tabBarItem.image = UIImage.init(named: normalImage)?.withRenderingMode(.alwaysOriginal)
//            vc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
            let navVc = BaseNavigationController.init(rootViewController: vc)
            navVc.tabBarItem.title = title
            navVc.tabBarItem.image = UIImage.init(named: normalImage)?.withRenderingMode(.alwaysOriginal)
            navVc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
            navVc.navigationBar.isHidden = true
            self.addChild(navVc)
        }
    }
    
    func setupChildsDynamicImages() {
        firstItemSelectAniImage = YYAnimatedImageView.init(image: UIImage(contentsOfFile: "tabbar_0_dynamic"))
        secondItemSelectAniImage = YYAnimatedImageView.init(image: UIImage(contentsOfFile: "tabbar_1_dynamic"))
        thirdItemSelectAniImage = YYAnimatedImageView.init(image: UIImage(contentsOfFile: "tabbar_2_dynamic"))
        
        selectImagesArr.removeAll()
        for idx in 0..<3 {
            selectImagesArr.append(UIImage.init(named: "tabbar_\(idx)_sel") ?? UIImage())
        }
    }
    
    //从网络获取TabBar图片
    private func setupChildViewControllerImageFromNet(_ vc:UIViewController,title:String, normalImage:String, selectedImage:String, placeholderNormal: String, placeholderSelected: String, animateImage: String) {
        var titl = title
        
        vc.tabBarItem.title = titl
        if let normalUrl = URL.init(string: normalImage) {
            do {
                let normalImageData = try Data.init(contentsOf: normalUrl)
                let normalImage = UIImage.init(data: normalImageData, scale: 3)
                vc.tabBarItem.image = normalImage?.withRenderingMode(.alwaysOriginal)
                //UIImage.scaleToSize(img: normalImage!, newsize: CGSize.init(width: 25, height: 25)).withRenderingMode(.alwaysOriginal)
            } catch {
                vc.tabBarItem.image = UIImage.init(named: placeholderNormal)?.withRenderingMode(.alwaysOriginal)
                print("生成图片失败")
            }
        }
        
        if let selectUrl = URL.init(string: selectedImage) {
            do {
                let selectImageData = try Data.init(contentsOf: selectUrl)
                let selectImage = UIImage.init(data: selectImageData, scale: 3)
                vc.tabBarItem.selectedImage = selectImage?.withRenderingMode(.alwaysOriginal)
                //UIImage.scaleToSize(img: selectImage!, newsize: CGSize.init(width: 25, height: 25)).withRenderingMode(.alwaysOriginal)
            } catch {
                print("生成图片失败")
                vc.tabBarItem.selectedImage = UIImage.init(named: placeholderSelected)?.withRenderingMode(.alwaysOriginal)
            }
        }
        self.addChild(vc)
    }
    
    
    //MARK: - notification
    func addNotice(){
       
    }
    
    func removeNotice() {
       
    }
    
    
    @objc func callUpInvientAction(notify: Notification) {
//        if SPublicVModel.shared.isInInfoCompleteV == true || UserDefaults.standard.integer(forKey: SNavBarSwitch) == 0 ||  SPublicVModel.isRoomExist() || CROneToOneVModel.isRoomExist(){
//            return
//        }
        
        if let userInfo = notify.userInfo as NSDictionary? {
            let info = JSON(userInfo)
            let nickname = info["nickname"].stringValue
            let profilePath = info["profilePath"].stringValue
            let crId = info["crId"].int64Value
            let roomTiTle = info["roomTiTle"].stringValue
            let isInGame = info["isInGame"].boolValue
            
//            let view = InvientNotificationView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//            view.drawGuessBgImageV.isHidden = true
//            view.inGameLabel.isHidden = true
//            view.initWithDetail(nickname: nickname, profilePath: profilePath, crId: crId, roomTiTle: roomTiTle, isInGame: isInGame)
//            SPublicVModel.shared.isInInfoCompleteV = true
//            view.animationShow()
        }
        
    }
    
    @objc func drawGuessCallAction(notify: Notification) {
//        if SPublicVModel.shared.isInInfoCompleteV == true || UserDefaults.standard.integer(forKey: SNavBarSwitch) == 0 ||  SPublicVModel.isRoomExist() || CROneToOneVModel.isRoomExist(){
//            return
//        }
//
//        if let userInfo = notify.userInfo as NSDictionary? {
//            let info = JSON(userInfo)
//            let nickname = info["nickname"].stringValue
//            let profilePath = info["profilePath"].stringValue
//            let crId = info["crId"].int64Value
//            let roomTiTle = info["roomTiTle"].stringValue
//            let isInGame = info["isInGame"].boolValue
//
//            let view = InvientNotificationView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//            view.drawGuessBgImageV.isHidden = false
//            view.inGameLabel.isHidden = false
//            view.initWithDetail(nickname: nickname, profilePath: profilePath, crId: crId, roomTiTle: roomTiTle, isInGame: isInGame)
//            SPublicVModel.shared.isInInfoCompleteV = true
//            view.animationShow()
//        }
        
    }
    
    @objc func dynamicallyPublishMessageReminders(notify: Notification) {
        Dprint("notify ==== \(notify)")
        if let userInfo = notify.userInfo as NSDictionary? {
            let info = JSON(userInfo)
            let ssId = info["ssId"].int64Value
            let sessionId = "ss" + String(ssId)
            let type = info["type"].intValue
            let workUrl = info["workUrl"].stringValue
            let workDes = info["workDes"].stringValue
            let addDate = info["addDate"].intValue
            
            let coverUrl = info["coverUrl"].stringValue
            let workId = info["workId"].intValue
            let photosUrl = info["photosUrl"].stringValue

//            SNIMMsgManager.sendDynamicallyPublishMessageRemindersMessage(ssId, sessionId: sessionId, type: type, workUrl: workUrl, workDes: workDes, addDate: addDate, coverUrl: coverUrl, workId: workId, photosUrl: photosUrl)
        }
    }
    
    
    // MARK: - 通知相关
//    @objc private func requestServerUnreadNumberAction() {
//        if UserInfo.mr_findFirst() == nil{ //未登录
//            UserDefaults.standard.set(0, forKey: SystemUnNotice)
//            UserDefaults.standard.set(0, forKey: InterActiveNoti)
//            UserDefaults.standard.set(0, forKey: OrderUnNotice)
//            UserDefaults.standard.set(0, forKey: AssignOrderNotice)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: REFRESHNOREAD), object: nil)
//        }else{
//            MessageRequestObj.share.requestUnRreadNotice()
//            MessageRequestObj.share.requestInterActionUnreadNewMessages()
//            RobOrderController.requestRobOrderList()
//            AORequestObj.share.requestAssignOrderList()
//            uploadUserInfo()
//        }
//    }
    
    @objc func goMessageNoticeAction(){
        if let ctrlArr = self.viewControllers{
            self.selectedIndex = ctrlArr.count-2
        }
    }
    
    //选中个人页面隐藏下单、选中其他页面根据条件显示下单
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if isAnimateTab {
            if self.selectedIndex == 0 {
                self.tabBar.items![self.selectedIndex].selectedImage = firstItemSelectAniImage.image?.withRenderingMode(.alwaysOriginal)
            } else if self.selectedIndex == 1 {
                self.tabBar.items![self.selectedIndex].selectedImage = secondItemSelectAniImage.image?.withRenderingMode(.alwaysOriginal)
            } else if self.selectedIndex == 2 {
                self.tabBar.items![self.selectedIndex].selectedImage = thirdItemSelectAniImage.image?.withRenderingMode(.alwaysOriginal)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.selectedIndex < self.selectImagesArr.count {
                    self.tabBar.items![self.selectedIndex].selectedImage = self.selectImagesArr[self.selectedIndex].withRenderingMode(.alwaysOriginal)
                }
            }
        }
    }
    
    
    //设置未读数角标
//    @objc func resetTabBarBadgeUnreadNumber(notifi: Notification) {
//        guard let tabbarItems = self.tabBar.items, !xReason else {return}
//        guard tabbarItems.count > 3 else {return}
//        let tabBarItem = tabbarItems[3]
//        let msgNum: Int = Tools.resetAppIconBageNumber()
//        Dprint("msgNummsgNummsgNummsgNum....\(msgNum)")
////        SPublicVModel.shared.messageNofiTipView.labNum = msgNum
//        if msgNum == 0 {
//            tabBarItem.badgeValue = nil
//        } else {
//            tabBarItem.badgeValue =  msgNum > 99 ? "99+" : "\(msgNum)"
//        }
//        //刷新私信列表
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kPriMsgNotification"), object: nil)
//        ///
//        if notifi.userInfo == nil || msgNum == 0 {
//            return
//        }
//        ///
//        if let userInfo = notifi.userInfo {
//            if let sessionId = userInfo["sessionId"] as? String {
//                SPublicVModel.shared.messageNofiTipView.sessionId = sessionId
//            }
//        }
//        if SPublicVModel.shared.messageNofiTipView.sessionId == "" || !SPublicVModel.shared.messageNofiTipView.sessionId.hasPrefix("ss") {
//            return
//        }
//        if UserDefaults.standard.bool(forKey: ProhibitPrivateMessagePush) {
//            return
//        }
////        let settings = UIApplication.shared.currentUserNotificationSettings
////        if settings?.types == UIUserNotificationType.init(rawValue: 0) && !UserHelper.hasSysNofTypeModeToday() {
//            /// 系统通知没有打开
//        if SPublicVModel.shared.messageNofiTipView.labNum != msgNum {
//            SPublicVModel.shared.messageNofiTipViewShow()
//            SPublicVModel.shared.messageNofiTipView.labText.text = "您有\(msgNum)条未读消息"
//            SPublicVModel.shared.messageNofiTipView.labNum = msgNum
//        }
//
//
////        }
//    }
     
    ///收到黄金锤点对点通知
//    @objc func receiveSuperGoldEggHammerAction(notify: Notification) {
//        if let userInfo = notify.userInfo {
//            guard let sendName = userInfo["sendCommodityName"] as? String else { return }
//            guard let giftUrl = userInfo["sendCommodityUrl"] as? String else { return }
//            guard let keyUrl = userInfo["commodityUrl"] as? String else { return }
//            guard let keyName = userInfo["commodityName"] as? String else { return }
//            guard let describ = userInfo["commodityTypeDesc"] as? String else { return }
//            guard let num = userInfo["num"] as? Int else { return }
//            // 0: 送礼   1：购买
//            let message = NIMMessage.init()
//            message.remoteExt = ["type":"3", "displayType":"10000"]
//            message.text = "恭喜您，\(describ)\(sendName) 获得了 \(keyName)x\(num)，可在背包里免费抽奖"
//
//            if UIViewController.getCurrentViewCtrl().isKind(of: ChatRoomController.classForCoder()) {
//                SRoomBoardObject.shared().addMsgToRoomDialogueView(msg: message)
//
//            } else if UIViewController.getCurrentViewCtrl().isKind(of: CROneToOneController.classForCoder()) {
//                CROneToOneVModel.shared().dialogView.dataArr.append(message)
//
//            } else {
//                let alertV = GoldenEggGetKeyAlertView.init(frame: UIViewController.getCurrentViewCtrl().view.bounds, sendGiftUrl: giftUrl, receiveKey: keyUrl, desc: describ)
//                alertV.animationShow()
//            }
//        }
//    }
    
    ///vip等级升级
//    @objc func receiveVipUpgreateSuccessAction(notify: Notification) {
//        if let userInfo = notify.userInfo as NSDictionary? {
//            if let jsonStr = userInfo["awardList"] as? String {
//                let jsonData = JSON.init(parseJSON: jsonStr).arrayValue
//                var listData: [CRVipUpgreateGiftCellModel] = [CRVipUpgreateGiftCellModel]()
//                for dict in jsonData {
//                    let model = CRVipUpgreateGiftCellModel.getModelFrom(json: dict)
//                    listData.append(model)
//                }
//                let upgreateV = CRVipUpgreateView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//                upgreateV.dataList = listData
//                upgreateV.animationShow()
//            }
//        }
//    }
    
    
    ///订单完成点对点通知
//    @objc func receiveOrderFinishSuccessAction(notify: Notification) {
//        if let userInfo = notify.userInfo as NSDictionary? {
//            if let jsonStr = userInfo["price"] as? Int {
//                let awardV = OrderFinishRedbagAlertView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//                awardV.priceLab.text = "\(jsonStr)"
//                awardV.animationShow()
//            }
//        }
//    }
    
    
    ///获取tabBar图片信息
    func getTabBarNetInfoToReset(){
//        SURLRequest.sharedInstance.requestPostWithHeader(Banner_TSYW_Icon_Url, param: ["code":38, "type": 1], checkSum: ["\(38)", "\(1)"], suc: { [weak self] (data) in
//            if let weakself = self {
//                let jsonData = JSON(data)
//                Dprint("Banner_TSYW_Icon_Url_Data: \(jsonData)")
//
//                if jsonData["result"].stringValue == "ok" {
//                    var infoModelArr: [BaseConfigInfoModel] = [BaseConfigInfoModel]()
//                    let contentArr = jsonData["content"].arrayValue
//                    for json in contentArr {
//                        let model = BaseConfigInfoModel.getModelFrom(json: json)
//                        infoModelArr.append(model)
//                    }
//
//                    var dicArr:[Any] = []
//                    for model in infoModelArr{
//                        let modelDic = model.dictionaryFromModel()
//                        dicArr.append(modelDic)
//                    }
//                    UserDefaults.TabbarInfo.set(value: dicArr, forKey: .imageUrlSelect)
//                }
//            }
//        }) { (error) in
//            Dprint("Banner_TSYW_Icon_Url_Error: \(error)")
//        }
    }
    
    ///上传用户额外信息
    private func uploadUserInfo(){
//        if let loginKey = UserInfo.mr_findFirst()?.loginKey{
//            let url = String.init(format: Save_User_Info_Url, loginKey)
//
//            let buildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
//            let currentVersion = String.init(format: "V%@.%@.%d", APP_VERSION,buildVersion,SCHANNEL_ID)
//
//            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//            Dprint("+++idfa=\(idfa)+++")
//
//            let parms = ["loginKey":loginKey,"province":idfa,"mac":"","system":2,"appVersion":currentVersion,"iccId":"","network":3,"imsi":"","imei":"","longitude":0.0,"latitude":0.0] as [String : Any]
//            let checkParms = [loginKey,idfa,"","2",currentVersion,"","3","","","0.0","0.0"]
//
//            SURLRequest.sharedInstance.requestPostWithHeader(url, param: parms, checkSum: checkParms, suc: { (data) in
//
//            }, err: { (error) in
//
//            })
//
//            // 获取用户匿名开关
//            if let ssId = UserInfo.mr_findFirst()?.ssId{
//                Tools.getPatData(ssId: ssId) { state, des in
//                    SPublicVModel.shared.isPatAnonymous = state == 1
//                }
//            }
//
//
//        }
    }
    
    func requestSendPatFunctionSwitch(type: Int){
//        SURLRequest.sharedInstance.requestPostWithHeader(URL_GetFunctionSwitch, param: ["type":type], checkSum: ["\(type)"], suc: {(data) in
//            Dprint("URL_GetFunctionSwitch:\(data)")
//            let jsonData = JSON(data)
//            if jsonData["result"].stringValue == "ok" {
//                let content = jsonData["content"].boolValue
//                SPublicVModel.shared.sendPatSwitch = content
//
//            }
//        }, err: { (error) in
//            Dprint("URL_GetFunctionSwitch:\(error)")
//        })
        
    }
    
//    ///循环判断
//    func whileToJudgeShowKickAlert(nickName: String) {
//        kickName = nickName
//        kickShowtimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//        kickShowtimer?.fire()
//    }
//
//    @objc func timerAction(timer: Timer) {
//        if !UIViewController.getCurrentViewCtrl().isKind(of: ChatRoomController.classForCoder()) {
//            let title = " 你已经被\(kickName)请出房间，目前无法进入该房间"
//            let alert = SAlertViewController.init(withTitle: "提示", alert: title, confirmTitle: "知道了", cancelTitle: "", confirmed: nil, canceled: nil)
//            alert.titleL.snp.remakeConstraints { (make) in
//                make.left.right.equalToSuperview().inset(WIDTH_SCALE(10))
//                make.top.equalToSuperview().inset(WIDTH_SCALE(10))
//                make.centerX.equalToSuperview()
//            }
//
//            alert.alertL.textColor = HEXCOLOR(h: 0x666666, alpha: 1.0)
//            alert.alertL.snp.remakeConstraints { (make) in
//                make.left.right.equalToSuperview().inset(WIDTH_SCALE(10))
//                make.top.equalTo(alert.titleL.snp.bottom).offset(WIDTH_SCALE(15))
//                make.centerX.equalToSuperview()
//            }
//
//            alert.confirmBtn.snp.remakeConstraints { (make) in
//                make.centerX.equalToSuperview()
//                make.bottom.equalToSuperview().inset(WIDTH_SCALE(18))
//                make.size.equalTo(CGSize(width: WIDTH_SCALE(90), height: WIDTH_SCALE(31)))
//            }
//
//            alert.cancelBtn.isHidden = true
//            alert.alertL.font = UIFont.systemFont(ofSize: WIDTH_SCALE(12))
//            alert.show()
//
//            timer.invalidate()
//        }
//
//    }
//
//    private func requestHeartBeat(){
//        guard let userInf = UserInfo.mr_findFirst() else {return}
//        let ssId = userInf.ssId
//        let url = String.init(format: URL_HeartBeat, ssId)
//        SURLRequest.sharedInstance.requestPostWithHeader(url, param: nil, checkSum: [String(ssId)], suc: { (data) in
////            Dprint("URL_HeartBeat===\(data)")
//        }) { (error) in
//            Dprint("URL_HeartBeat===\(error)")
//        }
//    }    //请求心跳接口
}
