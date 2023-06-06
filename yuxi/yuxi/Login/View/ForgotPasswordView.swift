//
//  ForgotPasswordView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/6.
//

import UIKit
import YYText_swift

class ForgotPasswordView: UIView {
    
    var bgView = UIView()
    var tipBgView = UIView()
    var tipLab = UILabel()
    var contentLab = YYLabel()
    var sureBtn = UIButton()
    
    var tel:String = "" {
        didSet {
            richTextAssignment(telS: tel)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YUXICOLOR(h: 0x000000, alpha: 0.5)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setUp() {
        
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = CGFloat(WIDTH_SCALE(20))
        bgView.layer.masksToBounds = true
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(319))
            make.height.equalTo(WIDTH_SCALE(240))
        }
        
        tipBgView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        bgView.addSubview(tipBgView)
        tipBgView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(48))
        }
        tipLab.text = "提示"
        tipLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        tipLab.font = UIFont.fontWith(.Semibold, size: 20)
        tipBgView.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
        // 文字描述
        contentLab.textColor = YUXICOLOR(h: 0xCCCCCC, alpha: 1)
        contentLab.numberOfLines = 0
        contentLab.font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(16*YUXIIPONE_SCALE))
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.width.equalTo(WIDTH_SCALE(289))
            make.height.equalTo(WIDTH_SCALE(46))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(WIDTH_SCALE(10))
        }
//        let userStr = "18888888888"
        
        
        
        
        
        sureBtn.setBackgroundImage(UIImage.init(named: "Login_Button_bg"), for: .normal)
        sureBtn.setTitle("知道了", for: .normal)
        sureBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        sureBtn.titleLabel?.font = UIFont.fontWith(size: 16)
        sureBtn.addTarget(self, action: #selector(closePopUpWindow), for: .touchUpInside)
        bgView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(142))
            make.height.equalTo(WIDTH_SCALE(32))
        }
        
    }
    
    func richTextAssignment(telS:String) {
        let resultStr = NSString.init(format: "      请联系管理员（%@）找回密码", telS)
        let attriStr = NSMutableAttributedString.init(string: resultStr as String)
        attriStr.yy_color = YUXICOLOR(h: 0x333333, alpha: 1)
        attriStr.yy_font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(16 * YUXIIPONE_SCALE))
                
        attriStr.addAttribute(NSAttributedString.Key.foregroundColor, value:YUXICOLOR(h: 0x1158F0, alpha: 1) , range: resultStr.range(of: telS))

        attriStr.yy_set(textHighlightRange: resultStr.range(of: telS), color: YUXICOLOR(h: 0x1158F0, alpha: 1), backgroundColor: .clear, userInfo: ["userName":tel]) { view, _, _, _ in
            UIApplication.shared.openURL(URL(string: "tel://\(telS)")! as URL)
            print("1")
        } longPress: {  view, _, _, rect in
            print("2")
            self.checkUser()
        }
        
        contentLab.attributedText = attriStr
    }
    
    func checkUser() {
        print("1")
    }
    
    
    ///展示方法
    func show() {
        self.frame = UIScreen.main.bounds
        UIViewController.getCurrentViewCtrl().view.addSubview(self)
    }
    
    //关闭弹窗
    @objc func closePopUpWindow() {
        close()
    }
    
    func close() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }

}
