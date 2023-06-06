//
//  SalaryListHeaderView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit

class SalaryListHeaderView: UIView {
    
    var bgView = UIView()
    var titleLab = UILabel()
    var incomeLab = UILabel()
    var image = UIImageView()
    var yearBgView = UIView()
    var yearBtn = UIButton()
    var yearArrow = UIImageView()
    
    let bgWidth = YUXISCREEN_HEIGHT - CGFloat(WIDTH_SCALE(36))

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        bgView.addGradientLayerWithBounds(colors: [YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor,YUXICOLOR(h: 0x3FA9F5, alpha: 1).cgColor], sBounds: CGRect.init(x: 0, y: 0, width: bgWidth, height: IPHONESEC(105)) ,locations: [0, 1],isHor: true)
        bgView.layer.cornerRadius = CGFloat(WIDTH_SCALE(5))
        bgView.clipsToBounds = true
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(9))
            make.centerX.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(105))
            make.left.right.equalToSuperview().inset(WIDTH_SCALE(18))
        }
        
        titleLab.text = "收入合计:"
        titleLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        titleLab.textAlignment = .left
        titleLab.font = UIFont.fontWith(size: 16)
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(20))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        
        incomeLab.text = "0"
        incomeLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        incomeLab.textAlignment = .left
        incomeLab.font = UIFont.fontWith(.Semibold,size: 24)
        bgView.addSubview(incomeLab)
        incomeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(20))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
        }
        
        image.image = UIImage(named: "Salary_Details_Bg")
        bgView.addSubview(image)
        image.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(93))
            make.width.equalTo(WIDTH_SCALE(193))
        }
        
        yearBgView.backgroundColor = YUXICOLOR(h: 0xFFFFFF, alpha: 0.5)
        yearBgView.corner(byRoundingCorners: [.topLeft, .bottomLeft], radii: CGFloat(WIDTH_SCALE(10)), rect: CGRect.init(x: 0, y: 0, width: CGFloat(WIDTH_SCALE(90)), height: CGFloat(WIDTH_SCALE(22))))
        bgView.addSubview(yearBgView)
        yearBgView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(90))
            make.height.equalTo(WIDTH_SCALE(22))
        }
        
        yearBtn.setTitle("\(Tools.dateConvertString(date: Date(), dateFormat: "yyyy"))年", for: .normal)
        yearBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        yearBtn.titleLabel?.font = UIFont.fontWith(size: 16)
        yearBtn.addTarget(self, action: #selector(yearBtnClick), for: .touchUpInside)
        yearBgView.addSubview(yearBtn)
        yearBtn.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(69))
        }
        
        yearArrow.image = UIImage(named: "arrow_width_right")
        yearBgView.addSubview(yearArrow)
        yearArrow.snp.makeConstraints { make in
            make.left.equalTo(yearBtn.snp.right)
            make.width.equalTo(WIDTH_SCALE(10))
            make.height.equalTo(WIDTH_SCALE(16))
            make.centerY.equalToSuperview()
        }
        
    }
    
    var yearBtnBlock:(()->())?
    @objc func yearBtnClick() {
        if let block = yearBtnBlock {
            block()
        }
    }

}
