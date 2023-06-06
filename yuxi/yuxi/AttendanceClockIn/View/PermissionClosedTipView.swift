//
//  PermissionClosedTipView.swift
//  yuxi
//
//  Created by 申修智 on 2023/6/3.
//

import UIKit

class PermissionClosedTipView: UIView {

    var bgView = UIView()
    var tipBgView = UIView()
    var tipLab = UILabel()
    var contentLab = UILabel()
    var sureBtn = UIButton()
    
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
        contentLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        contentLab.numberOfLines = 0
        contentLab.text = "定位权限被关闭,无法打卡,请点击下方按钮更改权限。"
        contentLab.font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(16*YUXIIPONE_SCALE))
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.width.equalTo(WIDTH_SCALE(289))
            make.height.equalTo(WIDTH_SCALE(46))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(WIDTH_SCALE(10))
        }
        
        sureBtn.setBackgroundImage(UIImage.init(named: "Login_Button_bg"), for: .normal)
        sureBtn.setTitle("去开启", for: .normal)
        sureBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        sureBtn.titleLabel?.font = UIFont.fontWith(size: 16)
        sureBtn.addTarget(self, action: #selector(surePopUpWindow), for: .touchUpInside)
        bgView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(142))
            make.height.equalTo(WIDTH_SCALE(32))
        }
        
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage.init(named: "Close_Width"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closePopUpWindow), for: .touchUpInside)
        self.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(WIDTH_SCALE(30))
            make.centerX.equalToSuperview()
            make.width.height.equalTo(WIDTH_SCALE(24))
        }
        
    }
    
    ///展示方法
    func show() {
        self.frame = UIScreen.main.bounds
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    //确定按钮
    @objc func surePopUpWindow() {
        closePopUpWindow()
        //打开设置界面
        if let url = URL(string: UIApplication.openSettingsURLString){
            if (UIApplication.shared.canOpenURL(url)){
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func closePopUpWindow() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }


}
