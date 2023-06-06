//
//  SalaryDetailsHeaderView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/29.
//

import UIKit

class SalaryDetailsHeaderView: UIView {
    
    var actualNumberLab = UILabel()
    var shouldNumberLab = UILabel()
    var abnormalNumberLab = UILabel()
    
    var model = MySalaryDetailsModel(){
        didSet{
            actualNumberLab.text = model.s_count
            abnormalNumberLab.text = model.deduct_sum
            shouldNumberLab.text = model.y_count
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        let topBgView = UIView()
        topBgView.backgroundColor =  YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.addSubview(topBgView)
        topBgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(180))
        }
        let bgImagv = UIImageView()
        bgImagv.image = UIImage(named: "My_Monthly_report_Bg")
        bgImagv.isUserInteractionEnabled = true
        topBgView.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-WIDTH_SCALE(5))
            make.width.equalTo(WIDTH_SCALE(175.44))
            make.height.equalTo(WIDTH_SCALE(171.81))
        }
        
        let realityLab = UILabel.init()
        realityLab.text = "实发金额"
        realityLab.textColor = .white
        realityLab.font = UIFont.fontWith(size: 16)
        topBgView.addSubview(realityLab)
        realityLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        actualNumberLab.text = "0"
        actualNumberLab.textColor = .white
        actualNumberLab.font = UIFont.fontWith(.Semibold, size: 22)
        topBgView.addSubview(actualNumberLab)
        actualNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(realityLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        let shouldLab = UILabel.init()
        shouldLab.text = "应发合计"
        shouldLab.textColor = .white
        shouldLab.font = UIFont.fontWith(size: 11)
        topBgView.addSubview(shouldLab)
        shouldLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(102))
        }
        shouldNumberLab.text = "0"
        shouldNumberLab.textColor = .white
        shouldNumberLab.font = UIFont.fontWith(size: 16)
        topBgView.addSubview(shouldNumberLab)
        shouldNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(shouldLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        let abnormalLab = UILabel.init()
        abnormalLab.text = "代扣合计"
        abnormalLab.textColor = .white
        abnormalLab.font = UIFont.fontWith(size: 11)
        topBgView.addSubview(abnormalLab)
        abnormalLab.snp.makeConstraints { make in
            make.left.equalTo(shouldLab.snp.right).offset(WIDTH_SCALE(97))
            make.top.equalToSuperview().offset(WIDTH_SCALE(102))
        }
        abnormalNumberLab.text = "0"
        abnormalNumberLab.textColor = .white
        abnormalNumberLab.font = UIFont.fontWith(size: 16)
        topBgView.addSubview(abnormalNumberLab)
        abnormalNumberLab.snp.makeConstraints { make in
            make.left.equalTo(abnormalLab)
            make.top.equalTo(abnormalLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
    }

}
