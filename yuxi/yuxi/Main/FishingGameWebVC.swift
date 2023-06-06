//
//  FishingGameWebVC.swift
//  Sheng
//
//  Created by lee on 2022/6/28.
//  Copyright © 2022 First Cloud. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
class FishingGameWebVC: YUXIBaseController,WKNavigationDelegate,WKUIDelegate, WKScriptMessageHandler {//,WKScriptMessageHandler
    
  
    var fromClass: AnyClass?
    
    var isBackToRoot: Bool = false
    
    var isNeedReload: Bool = false
    
    var freshRoomId: Int64 = 0
    /// 加载的url (必传)
    @objc var loadStr:String = "" {
        didSet{
//            shareUrlStr = loadStr

            if loadStr.hasSuffix("loginKey="){
                if let loginKey = (UserInfo.mr_findFirst()?.loginKey){
                    loadStr = loadStr + loginKey
                }
            }
        }
    }
 
    
    /// 网页控件
    var webView = WKWebView.init()
    
//    /// 分享视图对象
//    lazy var moreView:MoreShareView = {
//        let shareV = MoreShareView.init(frame: CGRect(x:0, y:SCREEN_HEIGHT, width:SCREEN_WIDTH, height: ISIPHONE6p ? 118 : 107))
//        return shareV
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedReload {
            loadNewData()
            isNeedReload = false
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow);
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "title" && fromClass != SFindVideoPlayViewController.classForCoder() && fromClass != PublishMomentsController.classForCoder(){
//            if isShowWebTitle {
//                self.navTitleL.text = self.webView.title
//            } else {
//                self.navTitleL.text = ""
//            }
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.updateWebsiteCache), object: nil)
 
    }
    
    // MARK: - PRIVATE
    private func setUI() {
        
        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: YUXISCREEN_HEIGHT))
        
        view.addSubview(webView)
        if let myURL = URL(string: loadStr) {
            var myRequest = URLRequest(url: myURL)
//            if isGame{
                myRequest.cachePolicy = .reloadIgnoringLocalCacheData
//            }
            webView.load(myRequest)
        }
        webView.navigationDelegate = self
        webView.uiDelegate = self
//        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
//        webView.scrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
//            self?.loadNewData()
//        })
        //        //获取WKUserContentController,并添加JS事件监听
        //        webView.configuration.userContentController.add(self, name: "gameJumpKongErIos")
//        if let updateUI = updateUI{
//            updateUI()
//        }
//        createWebNavigation()
//        self.perform(#selector(self.updateWebsiteCache), with: nil, afterDelay: 5) //更新的网页资源缓存
    }
    
//    func createWebNavigation() {
//        if isShareable{
//            self.createNavbar(navTitle: titleStr, leftImage: "L_back", rightImage: "share", ringhtAction: #selector(navRightAction))
//        }else{
//            self.createNavbar(navTitle: titleStr, leftImage: "L_back", rightImage: nil, ringhtAction: nil)
//        }
//    }
    
//    @objc func updateWebsiteCache(){
//
//        let webViewLocal = WKWebView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), configuration: WKWebViewConfiguration())
//        view.addSubview(webViewLocal)
//        if let myURL = URL(string: loadStr){
//            var myRequest = URLRequest(url: myURL)
//            myRequest.cachePolicy = .reloadIgnoringLocalCacheData
//            webViewLocal.load(myRequest)
//        }
//        webViewLocal.navigationDelegate = self
//        webViewLocal.uiDelegate = self
//        webViewLocal.isHidden = true
//    }
    
    @objc func loadNewData(){
        guard let absoluteString = self.webView.url?.absoluteString else { return }
        guard let myURL = URL(string: absoluteString) else {return}
        var myRequest = URLRequest(url: myURL)
        myRequest.cachePolicy = .reloadIgnoringLocalCacheData
        webView.load(myRequest)
    }
    
//    override func navBackAction() {
//        if self.webView.canGoBack && !isDirectBack{ //网页返回
//            if isGame{
//                if (self.webView.url?.absoluteString == loadStr) {
//                    super.navBackAction()
//                }else if webView.backForwardList.backItem?.url.absoluteString == loadStr {
//                    self.webView.goBack()
//                    self.loadNewData()
//                }else{
//                    self.webView.goBack()
//                }
//            }else{
//                self.webView.goBack()
//            }
//        } else {
//            if isBackToRoot {
//                if freshRoomId > 0 {
//                    SRoomBoardObject.enterChatRoom(roomId: freshRoomId)
//                    self.navigationController?.popViewController(animated: false)
//                } else {
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//
//            } else {
//                super.navBackAction()
//            }
//        }
//    }
    
//    @objc func navRightAction() {  //导航右侧点击
//        moreView.setParameter(shareIcon: SURLHelper.getNewImageUrl(imagePath: imgUrl, side: 100), mainTit: self.webView.title!, subTit: "吃瓜群众不明真相，争先恐后速来围观~", shareUr: isGame ? Game_Share_URL : shareUrlStr)
//        moreView.colorlessBackground.backgroundColor = .clear
//        moreView.animationshow(isCenter: false)
//    }
    
//    @objc func paySucNotice() {
//        self.loadNewData()
//    }
    
    // MARK: - WKUIDelegate
    //接收到警告面板
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - WKNavigationDelegate
    //加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        if (webView.scrollView.mj_header != nil) {
//            webView.scrollView.mj_header?.endRefreshing()
//        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        if (webView.scrollView.mj_header != nil) {
//            webView.scrollView.mj_header?.endRefreshing()
//        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        if (webView.scrollView.mj_header != nil) {
//            webView.scrollView.mj_header?.endRefreshing()
//        }
    }
    
    // 判断链接是否允许跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction:WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let absoluteStr = navigationAction.request.url?.absoluteString{ //拦截并跳转到指定页面
            Dprint("absoluteString === \(absoluteStr)")
            if absoluteStr.contains("req_") || absoluteStr.contains("req2_"){  //授权登录页
                if absoluteStr.contains("%accreditLogoutUrl_"){  //登录
                    let reqValueIndex = absoluteStr.positionOf(sub: "req_")! + "req_".count
                    let reqValue = absoluteStr.substring(startIndex: reqValueIndex, endIndex: reqValueIndex + 1)
                    let logoutUrlStrIndex = absoluteStr.index(absoluteStr.index(of: "%")!, offsetBy: "accreditLogoutUrl_".count+1)
                    let logoutUrlStr = String(absoluteStr[logoutUrlStrIndex...])//absoluteStr.substring(from: logoutUrlStrIndex)
                    Dprint("reqValue==\(reqValue)  logoutUrlStr==\(logoutUrlStr)")
//                    isDirectBack = true
                    if reqValue == "0"{
                        if let newUrl = URL(string: logoutUrlStr) {
                            let newRequest = URLRequest(url: newUrl)
                            webView.load(newRequest)
                        }
                        UIViewController.getCurrentViewCtrl().view.makeToast("授权成功", duration: 2.0, position: .center)
                    }else{
                        self.YUXInavBackAction()
                        UIViewController.getCurrentViewCtrl().view.makeToast("授权失败,请重新尝试!", duration: 2.0, position: .center)
                    }
                    decisionHandler(.cancel)
                    return
                }else{ //退出
                    let reqValueIndex = absoluteStr.positionOf(sub: "req2_")! + "req2_".count
                    let reqValue = absoluteStr.substring(startIndex: reqValueIndex, endIndex: reqValueIndex + 1)
                    Dprint("reqValue==\(reqValue)")
                    self.YUXInavBackAction()
                }
            }else if absoluteStr.contains("gameJumpKongErIos") || absoluteStr.contains("/beike.html") || absoluteStr.contains("/buykbi.html"){   //跳转到充值页面
//                if UserInfo.mr_findFirst() == nil{   //未登录
//                    let vc = YUXILoginAccountController()
//                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    let vc = MyWalletViewController.init()
//                    isNeedReload = true
//                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//                }
//                decisionHandler(.cancel)
//                return
            }else if absoluteStr.contains("/toushi.html") || absoluteStr.contains("/zuojia.html") || absoluteStr.contains("/qipao.html") || absoluteStr.contains("vipShop.html"){  //头饰商城
//                if UserInfo.mr_findFirst() == nil{   //未登录
//                    let vc = YUXILoginAccountController()
//                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    let tireVC = TireMallController()
//                    tireVC.isFromWebNobleMall = true
//                    self.navigationController?.pushViewController(tireVC, animated: true)
//                }
//                decisionHandler(.cancel)
//                return
            }else if absoluteStr.contains("/mytoushi"){ //我的商品
//                if UserInfo.mr_findFirst() == nil{   //未登录
//                    let vc = YUXILoginAccountController()
//                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    let myTireVC = MineBagViewController()
//                    self.navigationController?.pushViewController(myTireVC, animated: true)
//                }
//                decisionHandler(.cancel)
//                return
            }else if absoluteStr.contains("activityAwardJump") {  //领取奖励界面
//                if UserInfo.mr_findFirst() == nil{   //未登录
//                    let vc = YUXILoginAccountController()
//                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    let vc = ReceiveAwardCtrl.loadFromStoryboard(storyboard: "Mine")
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//                decisionHandler(.cancel)
//                return
            }else if absoluteStr.contains("inviteJump") {  //邀请好友
//                if let userInfo = UserInfo.mr_findFirst(){
//                    let shareUrlStr = App_Share_Outer_URL + userInfo.username!
//                    moreView.setParameter(shareIcon: userInfo.profilePath!, mainTit: "邀请好友", subTit: "【链接】\(userInfo.nickname!)邀请您和TA一起用声音链接你想要的", shareUr: shareUrlStr)
//                    moreView.animationshow(isCenter: false)
//                }else{   //未登录
//                    let vc = YUXILoginAccountController()
//                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
//                }
//                decisionHandler(.cancel)
                return
            }else if absoluteStr.contains("meetStrangers.html"){ //跳转到你好陌生人
//                let vc = FindStrangerViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//                decisionHandler(.cancel)
                return
            }else if absoluteStr.contains("matchingLudoGame.html"){ //跳转到飞行棋匹配
//                let vc: KEHangOutTogeTherController = KEHangOutTogeTherController()
//                vc.indexSel = 2
//                self.navigationController?.pushViewController(vc, animated: true)
//                decisionHandler(.cancel)
                return
            }else if absoluteStr.contains("playTogetherInHome.html"){ //跳转到首页一起玩游戏
//                let hangOutTogetherView = KEHangOutTogetherView.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: IPHONEX_BH + WIDTH_SCALE(278)))
//                UIViewController.getCurrentViewCtrl().tabBarController?.view.addSubview(hangOutTogetherView)
//                hangOutTogetherView.colorlessBackground.isHidden = false
//                hangOutTogetherView.isHidden = false
//                UIView.animate(withDuration: 0.25, animations: {
//                    hangOutTogetherView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - hangOutTogetherView.frame.size.height, width: SCREEN_WIDTH, height: hangOutTogetherView.frame.size.height)
//                })
//                decisionHandler(.cancel)
                return
            }else if absoluteStr.contains("publishVideo.html"){
//                if let realSkillNum = UserInfo.mr_findFirst()?.realSkillNum{
//                    if realSkillNum > 0{
//                        let vc = PublishMomentsController()
//                        vc.fromClass = self.classForCoder
//                        vc.isFromWebVC = 1
//                        vc.publishSucBlock = {
//                            let alert: UIAlertController = UIAlertController(title: "提示", message: "视频已提交成功\n请耐心等待官方审核结果", preferredStyle: .alert)
//                            let confirmAction: UIAlertAction = UIAlertAction(title: "确定", style: .cancel, handler: {(confirmAction) in
//                            })
//                            alert.addAction(confirmAction)
//                            UIViewController.getCurrentViewCtrl().present(alert, animated: true, completion: nil)
//                            //                                decisionHandler(.cancel)
//                        }
//                        self.navigationController?.pushViewController(vc, animated: true)
//                        decisionHandler(.cancel)
//                    }
//                    else{
//                        let alert: UIAlertController = UIAlertController(title: "提示", message: "本功能暂只对达人开放\n是否要去申请达人", preferredStyle: .alert)
//                        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: {(cancelAction) in
//
//                        })
//                        let confirmAction: UIAlertAction = UIAlertAction(title: "确定", style: .default, handler: {(confirmAction) in
//                            let mySkillNewVC = MySkillNewController()
//                            mySkillNewVC.tag = 0
//                            mySkillNewVC.enterType = .fromMine
//                            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(mySkillNewVC, animated: true)
//                        })
//                        alert.addAction(cancelAction)
//                        alert.addAction(confirmAction)
//                        UIViewController.getCurrentViewCtrl().present(alert, animated: true, completion: nil)
//                        decisionHandler(.cancel)
//                    }
//                }
                
                return
                
            }else if absoluteStr.contains("publishDynamic.html"){
                
//                let transition = CATransition.init()
//                transition.duration = 0.25
//                transition.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
//                transition.type = .moveIn
//                transition.subtype = .fromTop
//                transition.delegate = self
//                self.navigationController?.view.layer.add(transition, forKey: nil)
//                let vc = PublishMomentsController()
        //        vc.publishSucBlock = { [weak self] in
        //            if let weakSelf = self{
        ////                weakSelf.requestGetDynamicData()
        //            }
        //        }
//                self.navigationController?.pushViewController(vc, animated: false)
//                decisionHandler(.cancel)
                return
                
            }else if absoluteStr.contains("capsuleToys.html"){
//                if SPublicVModel.isRoomExist(){
//                    if CRViewModel.shared().capsuleToysTaskView.isAutoStatus {
//                        CRViewModel.closeTaskView()
//                    }
//                }
            }else if absoluteStr.contains("://close"){
                self.YUXInavBackAction()
                
            } else {
                if self.jumpToSomeControllerCroppedValue(absoluteStr: absoluteStr){
                    decisionHandler(.cancel)
                    return
                }
                if self.jumpToSomeControllerAbountIntegral(absoluteStr: absoluteStr){
                    decisionHandler(.cancel)
                    return
                }
            }
        }
        decisionHandler(.allow)
    }
    
    
    //    // MARK: - WKScriptMessageHandler
    //    //当接收到一个ScriptMessage（JS事件）时调用
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            Dprint("message.name==\(message.name)")
            if message.name == "showFullImageInfo"{ // 显示大图
                Dprint(message.body)

                let data = message.body
                let dataJson = JSON(data)
                let index = dataJson["index"].intValue
                let list = dataJson["list"].arrayValue
                var imageUrls:[String] = []
                for image in list {
                    let imageUrl = image.stringValue
                    imageUrls.append(imageUrl)
                }
                if index < imageUrls.count {
//                    let originImageViews:[UIImageView] = []
//                    let imageBrowserManger:LZImageBrowserManger = LZImageBrowserManger.imageBrowserManger(withUrlStr: imageUrls, originImageViews: originImageViews, originController: UIViewController.getCurrentViewCtrl(), forceTouch: false, forceTouchActionTitles: Array(repeating: "", count: imageUrls.count)) { (index, title) in
//                        Dprint("仿微信图片浏览\(index)===\(String(describing: title))")
//                        } as! LZImageBrowserManger
//                    imageBrowserManger.selectPage = index
//                    imageBrowserManger.showImageBrowser()
                }
            }else if message.name == "capsuleToysInfo"{ //出大礼物
                Dprint(message.body)

            }
        }
    
    // MARK: - Web跳转到App内置界面
    //裁剪出一些值并进行跳转
    private func jumpToSomeControllerCroppedValue(absoluteStr: String) -> Bool {
        let containStrArr = ["/info.html?ssId=","/skill.html?skillId=","/room.html?roomId="]
        for (index,containStr) in containStrArr.enumerated(){
            if absoluteStr.contains(containStr){
                if UserInfo.mr_findFirst() == nil{          //未登录
                    let vc = YUXILoginAccountController()
                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
                }else{
                    if index == 0{      //个人主页
                        let ssIdIndex = absoluteStr.index(absoluteStr.index(of: "=")!, offsetBy: 1)
                        let ssIdStr = String(absoluteStr[ssIdIndex...])//absoluteStr.substring(from: ssIdIndex)
                        if ssIdStr.count > 0{
                            if let ssId = Int64(ssIdStr){
                                if UserInfo.mr_findFirst() != nil{
                                    let tabbarVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                                    UIApplication.shared.keyWindow?.rootViewController = tabbarVC
                                }else{
                                    let vc = YUXILoginAccountController()
                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }else if index == 1{        //技能主页
                        let skillIDIndex = absoluteStr.index(absoluteStr.index(of: "=")!, offsetBy: 1)
                        let skillIDStr = String(absoluteStr[skillIDIndex...])//absoluteStr.substring(from: skillIDIndex)
                        if skillIDStr.count > 0{
                            if let skillID = Int64(skillIDStr){
//                                let skillVC = SkillMainViewController()
//                                skillVC.skillID = skillID
//                                self.navigationController?.pushViewController(skillVC, animated: true)
                            }
                        }
                    }else if index == 2{        //聊天室
                        let roomIdIndex = absoluteStr.index(absoluteStr.index(of: "=")!, offsetBy: 1)
                        let roomIdStr = String(absoluteStr[roomIdIndex...])//absoluteStr.substring(from: roomIdIndex)
                        if roomIdStr.count > 0{
                            if let roomID = Int64(roomIdStr){
                                if UserInfo.mr_findFirst() != nil {
//                                    SRoomBoardObject.enterChatRoom(roomId: roomID)
                                }else{
                                    
                                    let vc = YUXILoginAccountController()
                                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                }
                return true
            }
        }
        return false
    }
    
    private func jumpToSomeControllerAbountIntegral(absoluteStr: String) -> Bool {
        let containStrArr = ["/integralDetails.html","/voiceSignature.html","/voiceProperty.html","/bindingPhone.html","/giveGifts.html","/sendMessage.html","/likenumInt.html","/onlineTime.html","/matchRoom.html","/sendGift.html","/matchGuessRoom.html","/matchArbitrarilyRoom.html","/matchHottestRoom.html","/matchOrderPage.html","/matchMyWallet.html", "/matchMyWallet11.html","/matchRapidAccessRoom.html","/NewWelfare11.html","/NewWelfare12.html","/jumpRiverRoom.html","/ManitoList.html","/shareUrl.html", "/goToRedBagList.html", "/placeOrder.html"]
        for containStr in containStrArr{
            if absoluteStr.contains(containStr){
                if UserInfo.mr_findFirst() == nil{          //未登录
                    let vc = YUXILoginAccountController()
                    UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
                    return true
                }else{
                    
                }
            }
        }
        return false
    }
    
}
