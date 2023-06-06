//
//  MyAttendanceHeaderView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/15.
//

import UIKit

class MyAttendanceHeaderView: UIView {
    
    var dateLab = UILabel()
    
    var monthlyReportBtn = UIButton()
    
    var calendarView:MyAttendanceCalendarView!
    
    var blueView = UIView()
    var redView = UIView()
    var blueLab = UILabel()
    var redLab = UILabel()
    var lineView = UIView()
    
    let arrawBtn = UIButton()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI() {
        let dateY = Tools.dateConvertString(date: Date(), dateFormat: "yyyy")
        let dateM = Tools.dateConvertString(date: Date(), dateFormat: "MM")
        dateLab.text = dateY+"年|"+dateM+"月"
        dateLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        dateLab.font = UIFont.fontWith(size: 16)
        self.addSubview(dateLab)
        dateLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(18))
        }
        
        monthlyReportBtn.setTitle("我的月报", for: .normal)
        monthlyReportBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        monthlyReportBtn.titleLabel?.font = UIFont.fontWith(size: 16)
        self.addSubview(monthlyReportBtn)
        monthlyReportBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-19))
            make.top.equalToSuperview().offset(WIDTH_SCALE(18))
        }
        
        arrawBtn.setImage(UIImage.init(named: "R_back_width"), for: .normal)
        self.addSubview(arrawBtn)
        arrawBtn.snp.makeConstraints { make in
            make.left.equalTo(monthlyReportBtn.snp.right).offset(WIDTH_SCALE(3))
            make.centerY.equalTo(monthlyReportBtn)
            make.width.equalTo(WIDTH_SCALE(7.5))
            make.height.equalTo(WIDTH_SCALE(12))
        }

        
        calendarView = MyAttendanceCalendarView()
        calendarView.backgroundColor = .white
        self.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(dateLab.snp.bottom).offset(WIDTH_SCALE(18))
            make.height.equalTo(WIDTH_SCALE(297))
        }
        var bottomView = UIView.init()
        bottomView.backgroundColor = .white
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        
        blueView.backgroundColor = .blue
        blueView.layer.cornerRadius = CGFloat(WIDTH_SCALE(3))
        blueView.layer.masksToBounds = true
        self.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(calendarView.snp.bottom).offset(WIDTH_SCALE(25))
            make.width.height.equalTo(WIDTH_SCALE(6))
        }
        
        redView.backgroundColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
        redView.layer.cornerRadius = CGFloat(WIDTH_SCALE(3))
        redView.layer.masksToBounds = true
        self.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(blueView.snp.bottom).offset(WIDTH_SCALE(21))
            make.width.height.equalTo(WIDTH_SCALE(6))
        }
        
        blueLab.text = "全天考勤正常"
        blueLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        blueLab.font = UIFont.fontWith(size: 12)
        self.addSubview(blueLab)
        blueLab.snp.makeConstraints { make in
            make.left.equalTo(blueView.snp.right).offset(WIDTH_SCALE(6))
            make.centerY.equalTo(blueView)
        }
        
        redLab.text = "当天存在异常：迟到、早退、缺卡"
        redLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        redLab.font = UIFont.fontWith(size: 12)
        self.addSubview(redLab)
        redLab.snp.makeConstraints { make in
            make.left.equalTo(redView.snp.right).offset(WIDTH_SCALE(6))
            make.centerY.equalTo(redView)
        }
        
        lineView.backgroundColor = YUXICOLOR(h: 0xE4E4E4, alpha: 1)
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.height.equalTo(WIDTH_SCALE(1))
            make.top.equalTo(redLab.snp.bottom).offset(WIDTH_SCALE(20))
        }
        
    }
    
    
    
    

}
