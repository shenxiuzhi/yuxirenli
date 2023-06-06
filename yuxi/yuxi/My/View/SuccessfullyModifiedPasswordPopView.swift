//
//  SuccessfullyModifiedPasswordPopView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/11.
//

import UIKit

class SuccessfullyModifiedPasswordPopView: UIView {
    
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
        contentLab.text = "初始密码修改成功"
        contentLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        contentLab.numberOfLines = 0
        contentLab.font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(16*YUXIIPONE_SCALE))
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.width.equalTo(WIDTH_SCALE(289))
            make.height.equalTo(WIDTH_SCALE(46))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(WIDTH_SCALE(10))
        }
        
        sureBtn.setBackgroundImage(UIImage.init(named: "Login_Button_bg"), for: .normal)
        sureBtn.setTitle("我知道了", for: .normal)
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
    

    ///展示方法
    func show() {
        self.frame = UIScreen.main.bounds
        UIViewController.getCurrentViewCtrl().view.addSubview(self)
    }
    
    var closePopUpBlock:(()->())?
    //关闭弹窗
    @objc func closePopUpWindow() {
        if let block = closePopUpBlock{
            block()
        }
        close()
    }
    
    func close() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }

}
