//
//  SalaryStatisticsHeadView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/16.
//

import UIKit

class SalaryStatisticsHeadView: UIView {
    
    var yearBtn = UIButton()
    var totalSalaryLab = UILabel()
    var totalSalarySumLab = UILabel()
    var totalBonusLab = UILabel()
    var totalBonusSumLab = UILabel()
    
    var dateSelection:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI(){
        yearBtn.setTitle("2023年", for: .normal)
        yearBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        yearBtn.titleLabel?.font = UIFont.fontWith(size: 16)
        yearBtn.addTarget(self, action: #selector(yearAction), for: .touchUpInside)
        self.addSubview(yearBtn)
        yearBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(10))
        }
        let arrawBtn = UIButton()
        arrawBtn.setImage(UIImage.init(named: "arraw_bottom_width"), for: .normal)
        arrawBtn.addTarget(self, action: #selector(yearAction), for: .touchUpInside)
        self.addSubview(arrawBtn)
        arrawBtn.snp.makeConstraints { make in
            make.left.equalTo(yearBtn.snp.right)
            make.centerY.equalTo(yearBtn)
            make.width.height.equalTo(WIDTH_SCALE(12))
        }
        
        totalSalaryLab.text = "基本工资合计"
        totalSalaryLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        totalSalaryLab.font = UIFont.fontWith(size: 11)
        self.addSubview(totalSalaryLab)
        totalSalaryLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(yearBtn.snp.bottom).offset(WIDTH_SCALE(10))
        }
        
        totalSalarySumLab.textColor = YUXICOLOR(h: 0xFFFFFf, alpha: 1)
        totalSalarySumLab.font = UIFont.fontWith(.Semibold, size: 22)
        self.addSubview(totalSalarySumLab)
        totalSalarySumLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(totalSalaryLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        
        totalBonusLab.text = "奖金合计"
        totalBonusLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        totalBonusLab.font = UIFont.fontWith(size: 11)
        self.addSubview(totalBonusLab)
        totalBonusLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(169))
            make.top.equalTo(yearBtn.snp.bottom).offset(WIDTH_SCALE(10))
        }
        
        totalBonusSumLab.textColor = YUXICOLOR(h: 0xFFFFFf, alpha: 1)
        totalBonusSumLab.font = UIFont.fontWith(.Semibold, size: 22)
        self.addSubview(totalBonusSumLab)
        totalBonusSumLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(169))
            make.top.equalTo(totalBonusLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        
        
    }
    
    @objc func yearAction() {
        if let block = dateSelection {
            block()
        }
    }
    
    
    
}
