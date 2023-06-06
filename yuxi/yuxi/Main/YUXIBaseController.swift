//
//  YUXIBaseController.swift
//  yuxi
//
//  Created by DS on 2023/4/28.
//  Copyright © 2023年 First Cloud. All rights reserved.
//

/**
 * @brief: 视图控制器基类
 */

import UIKit
import SnapKit

class YUXIBaseController: UIViewController {
    
    
    
    /// 创建导航(返回按钮为图片,右侧按钮为文字或无)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - leftImage: 返回按钮图片
    ///   - rightImage: 右侧按钮标题
    ///   - ringhtAction: 右侧按钮方法
    func YUXICreateNavbar(navTitle:String, leftImage:String?, rightStr:String?, ringhtAction:Selector?, rightIsImage: Bool,titleIsRight:Bool) {
        self.YUXICreateNavbars(navTitle: navTitle, leftIsImage: true, leftStr: leftImage, rightIsImage: rightIsImage, rightStr: rightStr, leftAction: nil, ringhtAction: ringhtAction, titleIsRight:titleIsRight)
    }
    
    
    /// 创建导航(返回按钮为图片,右侧按钮为文字或无)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - leftImage: 返回按钮图片
    ///   - rightImage: 右侧按钮标题
    ///   - ringhtAction: 右侧按钮方法
    func YUXICreateNavbar(navTitle:String, leftImage:String?, rightStr:String?, leftAction:Selector? , ringhtAction:Selector?,titleIsRight:Bool) {
        self.YUXICreateNavbar(navTitle: navTitle, leftIsImage: true, leftStr: leftImage, rightIsImage: false, rightStr: rightStr, leftAction: leftAction, ringhtAction: ringhtAction,titleIsRight:titleIsRight)
    }
    
    
    /// 创建导航(左侧按钮为文字,右侧按钮为文字或无)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - leftTitle: 左侧按钮标题
    ///   - rightTitle: 右侧按钮标题
    ///   - leftAction: 左侧按钮方法
    ///   - ringhtAction: 右侧按钮方法
    func YUXICreateNavbar(navTitle:String, leftTitle:String?, rightTitle:String?, leftAction:Selector?, ringhtAction:Selector?,titleIsRight:Bool) {
        self.YUXICreateNavbar(navTitle: navTitle, leftIsImage: false, leftStr: leftTitle, rightIsImage: false, rightStr: rightTitle, leftAction: leftAction, ringhtAction: ringhtAction,titleIsRight:titleIsRight)
    }
    
    /// 创建导航(左侧按钮为文字,右侧按钮为图片或无)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - leftTitle: 左侧按钮标题
    ///   - rightImage: 右侧按钮标题
    ///   - leftAction: 左侧按钮方法
    ///   - ringhtAction: 右侧按钮方法
    func YUXICreateNavbar(navTitle:String, leftTitle:String?, rightImage:String?, leftAction:Selector?, ringhtAction:Selector?,titleIsRight:Bool) {
        self.YUXICreateNavbar(navTitle: navTitle, leftIsImage: false, leftStr: leftTitle, rightIsImage: true, rightStr: rightImage, leftAction: leftAction, ringhtAction: ringhtAction,titleIsRight:titleIsRight)
    }
    
    /// 创建导航(标题在左边)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - navTitleColorIsWidth: 标题是否为白色
    func YUXICreateNavbarLeft(navTitle:String, navTitleColorIsWidth:Bool) {
        self.YUXICreateNavbar(navTitle: navTitle,navTitleColorIsWidth: navTitleColorIsWidth)
    }
    
    
    //    private func YUXICreateNavbar(navTitle:String, leftIsImage:Bool, leftStr:String?, rightIsImage:Bool, rightStr:String?, leftAction:Selector?, ringhtAction:Selector? ,ShowBgImg:Bool)
    
    
    // MARK: - PRIVATE
    private func YUXICreateNavbar(navTitle:String, leftIsImage:Bool, leftStr:String?, rightIsImage:Bool, rightStr:String?, leftAction:Selector?, ringhtAction:Selector?,titleIsRight:Bool) {
        //背景
        self.view.addSubview(navBarV)
        navBarV.snp.makeConstraints { (bkmaker) in
            bkmaker.left.top.right.equalToSuperview()
            bkmaker.height.equalTo(YUXISTATUSBAR_HEIGHT+YUXINavbarHeight)
        }
        //返回按钮
        if leftIsImage {
            if let leftStr = leftStr{
                backBtn.setImage(UIImage.init(named: leftStr), for: .normal)
            }else{
                backBtn.setImage(UIImage.init(named: "L_back_width"), for: .normal)
            }
        }else{
            if let leftStr = leftStr {
                backBtn.setTitle(leftStr, for: .normal)
                backBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
                backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        if let leftAction = leftAction {
            backBtn.addTarget(self, action: leftAction, for: .touchUpInside)
        }else{
            backBtn.addTarget(self, action: #selector(YUXInavBackAction), for: .touchUpInside)
        }
        navBarV.addSubview(backBtn)
        backBtn.snp.makeConstraints { (bkmaker) in
            bkmaker.left.bottom.equalToSuperview()
            bkmaker.height.width.equalTo(YUXINavbarHeight)
        }
        //右侧按钮
        if rightIsImage{
            if let rightString = rightStr {
                rightBtn.setImage(UIImage.init(named: rightString), for: .normal)
            }
        }else{
            if let rightString = rightStr {
                rightBtn.setTitle(rightString, for: .normal)
                rightBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
                rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
        }
        if let ringhtAction = ringhtAction {
            rightBtn.addTarget(self, action: ringhtAction, for: .touchUpInside)
        }
        navBarV.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (bkmaker) in
            bkmaker.right.bottom.equalToSuperview()
            bkmaker.height.equalTo(YUXINavbarHeight)
            bkmaker.width.equalTo(titleIsRight ? YUXINavbarHeight:90)
        }
        //标题
        YUXInavTitleL.text = navTitle
        if leftStr == "L_back_white"{
            YUXInavTitleL.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        }else{
            YUXInavTitleL.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        }
        
        YUXInavTitleL.textAlignment = titleIsRight ? .left : .center
        navBarV.addSubview(YUXInavTitleL)
        YUXInavTitleL.snp.makeConstraints { (bkmaker) in
            if titleIsRight {
                if leftStr == "" {
                    bkmaker.left.equalToSuperview().offset(WIDTH_SCALE(18))
                }
                bkmaker.left.equalTo(backBtn.snp.right)
            }else {
                bkmaker.centerX.equalToSuperview()
            }
            bkmaker.right.equalTo(rightBtn.snp.left).offset(-10)
            bkmaker.bottom.equalToSuperview()
            bkmaker.height.equalTo(YUXINavbarHeight)
        }
    }
    
    // MARK: - PRIVATE
    private func YUXICreateNavbars(navTitle:String, leftIsImage:Bool, leftStr:String?, rightIsImage:Bool, rightStr:String?, leftAction:Selector?, ringhtAction:Selector? ,titleIsRight:Bool) {
        //背景
        self.view.addSubview(navBarV)
        navBarV.snp.makeConstraints { (bkmaker) in
            bkmaker.left.top.right.equalToSuperview()
            bkmaker.height.equalTo(YUXISTATUSBAR_HEIGHT+YUXINavbarHeight)
        }
        //返回按钮
        if leftIsImage {
            if let leftStr = leftStr{
                backBtn.setImage(UIImage.init(named: leftStr), for: .normal)
            }else{
                backBtn.setImage(UIImage.init(named: "L_back_width"), for: .normal)
            }
        }else{
            if let leftStr = leftStr {
                backBtn.setTitle(leftStr, for: .normal)
                backBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
                backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        if let leftAction = leftAction {
            backBtn.addTarget(self, action: leftAction, for: .touchUpInside)
        }else{
            backBtn.addTarget(self, action: #selector(YUXInavBackAction), for: .touchUpInside)
        }
        navBarV.addSubview(backBtn)
        backBtn.snp.makeConstraints { (bkmaker) in
            bkmaker.left.bottom.equalToSuperview()
            bkmaker.height.width.equalTo(YUXINavbarHeight)
        }
        //右侧按钮
        if rightIsImage{
            if let rightString = rightStr {
                rightBtn.setImage(UIImage.init(named: rightString), for: .normal)
            }
        }else{
            if let rightString = rightStr {
                rightBtn.setTitle(rightString, for: .normal)
                rightBtn.setTitleColor(YUXICOLOR(h: 0x333333, alpha: 1), for: .normal)
                rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
        }
        if let ringhtAction = ringhtAction {
            rightBtn.addTarget(self, action: ringhtAction, for: .touchUpInside)
        }
        
        navBarV.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (bkmaker) in
            bkmaker.right.bottom.equalToSuperview()
            bkmaker.height.equalTo(YUXINavbarHeight)
            bkmaker.width.equalTo(WIDTH_SCALE(80))
        }
        //标题
        YUXInavTitleL.text = navTitle
        YUXInavTitleL.textAlignment = titleIsRight ? .left : .center
        navBarV.addSubview(YUXInavTitleL)
        YUXInavTitleL.snp.makeConstraints { (bkmaker) in
            if titleIsRight {
                bkmaker.left.equalTo(backBtn.snp.right)
            }else {
                bkmaker.centerX.equalToSuperview()
            }
            bkmaker.right.equalTo(rightBtn.snp.left).offset(-10)
            bkmaker.bottom.equalToSuperview()
            bkmaker.height.equalTo(YUXINavbarHeight)
        }
        
        
    }
    
    // MARK: - PRIVATE
    private func YUXICreateNavbar(navTitle:String,navTitleColorIsWidth:Bool=true) {
        //背景
        self.view.addSubview(navBarV)
        navBarV.snp.makeConstraints { (bkmaker) in
            bkmaker.left.top.right.equalToSuperview()
            bkmaker.height.equalTo(YUXISTATUSBAR_HEIGHT+YUXINavbarHeight)
        }
        //返回按钮
        backBtn.isHidden = true
        rightBtn.isHidden = true
        
        //标题
        YUXInavTitleL.text = navTitle
        if navTitleColorIsWidth {
            YUXInavTitleL.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        }else{
            YUXInavTitleL.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        }
        
        YUXInavTitleL.textAlignment = .left
        navBarV.addSubview(YUXInavTitleL)
        YUXInavTitleL.snp.makeConstraints { (bkmaker) in
            bkmaker.left.equalToSuperview().offset(WIDTH_SCALE(18))
            bkmaker.right.equalToSuperview().offset(-10)
            bkmaker.bottom.equalToSuperview()
            bkmaker.height.equalTo(YUXINavbarHeight)
        }
    }
    
    
    /// 导航标题
    lazy var YUXInavTitleL:UILabel = {
        let nTitle = UILabel.init()
        nTitle.textAlignment = .center
        nTitle.font = UIFont.init(name: "PingFangSC-Semibold", size: WIDTH_SCALE(18))
        nTitle.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        return nTitle
    }()
    
    /// 导航是否是透明色
    var isNavBarClear:Bool = false{
        didSet{
            if isNavBarClear == true{
                navBarV.backgroundColor = .clear
                YUXInavTitleL.textColor = .white
                if rightBtn.title(for: .normal) != nil{
                    rightBtn.setTitleColor(.white, for: .normal)
                }
            }else{
                navBarV.backgroundColor = .white
                YUXInavTitleL.textColor = .black
                if rightBtn.title(for: .normal) != nil{
                    rightBtn.setTitleColor(YUXICOLOR(h: 0x303030, alpha: 1), for: .normal)
                }
            }
        }
    }
    
    //设置导航栏透明度
    var navbarAlpha:CGFloat = 0 {
        didSet{
            navBarV.alpha = navbarAlpha
        }
    }
    
    // MARK: - PRIVAE
    lazy var navBarV:UIView = {
        let barV = UIView.init()
        barV.backgroundColor = .white
        return barV
    }()  // 导航背景
    
    private lazy var backBtn:UIButton = {
        let bBtn = UIButton.init(type: .custom)
        return bBtn
    }()
    
    var isHiddenBackBtn = false{
        didSet{
            backBtn.isHidden = isHiddenBackBtn
        }
    }
    
    
    private lazy var bgImg:UIImageView = {
        let bgImg = UIImageView.init()
        bgImg.image = UIImage.init(named: "YUXI_content_bgImg")
        return bgImg
    }()
    
    
    lazy var rightBtn:UIButton = {
        let rBtn = UIButton.init(type: .custom)
        return rBtn
    }()
    
    // MARK: - system method
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .default
//        IQKeyboardManager.shared.enable = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - public method
    //从 storyboard 中获取视图控制器
    static func loadFromStoryboard(storyboard:String) -> UIViewController {
        if let identifier = NSStringFromClass(self.classForCoder()) .components(separatedBy: ".") .last{
            return UIStoryboard(name: storyboard,bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
        }else{
            print("视图控制器 loadFromStoryboard 失败")
            return UIViewController.init()
        }
    }
    
    
    /// 返回方法(可重写)
    @objc public func YUXInavBackAction() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion:nil)
    }
    
    /// 重设导航
    ///
    /// - Parameters:
    ///   - isClear: 是否透明 是_文字为白色
    ///   - leftImage: 左边图片
    ///   - rightImage: 右边图片
    func resetNavbar(isClear:Bool?, leftImage:String?, rightImage:String?) {
        if let isClear = isClear{
            self.isNavBarClear = isClear
        }
        if let leftStr = leftImage{
            backBtn.setImage(UIImage.init(named: leftStr), for: .normal)
        }else{
            backBtn.setImage(UIImage.init(named: "BYY_NewReturn"), for: .normal)
        }
        if let rightString = rightImage {
            rightBtn.setImage(UIImage.init(named: rightString), for: .normal)
        }
    }
    
}
