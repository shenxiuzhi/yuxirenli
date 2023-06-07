//
//  loginPrivacyAgreementView.swift
//  Sheng
//
//  Created by dousheng on 2022/12/7.
//  Copyright © 2022 First Cloud. All rights reserved.
//

import UIKit
import YYText_swift
class loginPrivacyAgreementView: UIView {
    
    
    // 判断是否同意协议
    var isAgree:Bool = true {
        didSet {
            agreeBtn.isSelected = isAgree == true ? true : false
        }
    }
    
    // 是否同意
    var block_isAgreed: ((_ isAgree: Bool)->())?
    
    // 同意按钮
    let agreeBtn = UIButton()
//    // 我已同意并阅读
    let agreeLabeL = YYLabel()
//    // 用户协议字体视图
//    let agreeMentV = UIView()
//    // 用户协议
//    let agreeMentL = UILabel()
//    // 和
//    let andLabel = UILabel()
//    // 隐私政策字体视图
//    let privateCategeryV = UIView()
//    // 隐私政策
//    let privateCategeryL = UILabel()
//

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpInterface() {
        
        // 同意协议按钮
        agreeBtn.isSelected = true
        agreeBtn.setImage(UIImage(named:"BYY_NewSelect"), for: .normal)
        agreeBtn.setImage(UIImage(named:"BYY_NewUnSelect"), for: .selected)
        agreeBtn.addTarget(self, action: #selector(agreeAction(button:)), for: .touchUpInside)
        self.addSubview(agreeBtn)
        agreeBtn.snp.makeConstraints { (bkmaker) in
            bkmaker.top.equalToSuperview()
            bkmaker.height.width.equalTo(14*YUXIIPONE_SCALE)
            bkmaker.left.equalTo(79*YUXIIPONE_SCALE)
        }
        // 文字描述

        agreeLabeL.textColor = YUXICOLOR(h: 0xCCCCCC, alpha: 1)
        agreeLabeL.numberOfLines = 0
        agreeLabeL.font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(12*YUXIIPONE_SCALE))
        self.addSubview(agreeLabeL)
        agreeLabeL.snp.makeConstraints { (bkmaker) in
            bkmaker.left.equalTo(agreeBtn.snp.right).offset(CGFloat(5*YUXIIPONE_SCALE))
            bkmaker.right.equalTo(-29*YUXIIPONE_SCALE)
            bkmaker.height.equalTo(35*YUXIIPONE_SCALE)
            bkmaker.centerY.equalTo(agreeBtn)
        }
        let userStr = "《服务协议》"
        let resStr = "《隐私政策》"
        let resultStr = NSString.init(format: "我已阅读并同意%@、%@", resStr,userStr)
        let attriStr = NSMutableAttributedString.init(string: resultStr as String)
        attriStr.yy_color = YUXICOLOR(h: 0x333333, alpha: 1)
        attriStr.yy_font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(12 * YUXIIPONE_SCALE))
        
        
        attriStr.yy_set(textHighlightRange: resultStr.range(of: resStr), color: YUXICOLOR(h: 0x1158F0, alpha: 1), backgroundColor: .clear, userInfo: ["userName":resStr]) { view, _, _, _ in
            
            self.agreenAndcheck(type: 1)
        } longPress: {  view, _, _, rect in
            print("2")
//            self.checkUser()
        }
        
        attriStr.yy_set(textHighlightRange: resultStr.range(of: userStr), color: YUXICOLOR(h: 0x1158F0, alpha: 1), backgroundColor: .clear, userInfo: ["userName":userStr]) { view, _, _, _ in
            
            self.agreenAndcheck(type: 2)
        } longPress: {  view, _, _, rect in
            print("2")
//            self.checkUser()
        }

        agreeLabeL.attributedText = attriStr
        
    }
    
    
    // MARK: - 同意 / 拒绝 （用户协议&&隐私政策）
    @objc func agreeAction(button:UIButton){
        button.isSelected = !button.isSelected
        self.isAgree = button.isSelected
        if let block = block_isAgreed {
            block(isAgree)
        }
        
    }
    
    var agreen_checkBlock:((_ type:Int)->())?
    func agreenAndcheck(type:Int){
        if let block = agreen_checkBlock{
            block(type)
        }
    }
    
    //    // MARK: - 用户协议&&隐私政策
    //查看用户协议
     func agreenUser(){

    }

    //查看隐私策略
    func checkUser(){

    }

}
