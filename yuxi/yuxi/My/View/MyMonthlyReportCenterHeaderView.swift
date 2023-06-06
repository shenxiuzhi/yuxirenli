//
//  MyMonthlyReportCenterHeaderView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/29.
//

import UIKit

class MyMonthlyReportCenterHeaderView: UIView {
    
    var actualNumberLab = UILabel()//实际出勤数
    var shouldNumberLab = UILabel()//应出勤数
//    var abnormalNumberLab = UILabel()//异常出勤数
    
    var monthLab = UILabel()
    
    var earlyNumberLab = UILabel()
    var inNumberLab = UILabel()
    var nightNumberLab = UILabel()
    var workOvertimeNumberLab = UILabel()
    var festivalAndHolidayNumberLab = UILabel()
    var absencesNumberLab = UILabel()
    var leaveEarlyNumberLab = UILabel()
    var missNumberLab = UILabel()
    
    var model = MyMonthlyReportCenterModel(){
        didSet {
            actualNumberLab.text = model.reality_day+"次"
            shouldNumberLab.text = model.should_day+"次"
//            abnormalNumberLab.text = model.
            earlyNumberLab.text = model.early_day+"次"
            inNumberLab.text = model.middle_day+"次"
            nightNumberLab.text = model.night_day+"次"
            workOvertimeNumberLab.text = model.extra_day+"次"
            festivalAndHolidayNumberLab.text = model.legal_day+"次"
            absencesNumberLab.text = model.qq_day
            leaveEarlyNumberLab.text = model.zt_day
            missNumberLab.text = model.cd_day
            
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
            make.height.equalTo(WIDTH_SCALE(214))
        }
        let bgImagv = UIImageView()
        bgImagv.image = UIImage(named: "My_Monthly_report_Bg")
        bgImagv.isUserInteractionEnabled = true
        topBgView.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(175.44))
            make.height.equalTo(WIDTH_SCALE(171.81))
        }
        
        let statisticsLab = UILabel()
        statisticsLab.text = "上下班统计"
        statisticsLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        statisticsLab.font = UIFont.fontWith(.Semibold, size: 16)
        topBgView.addSubview(statisticsLab)
        statisticsLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.width.equalTo(WIDTH_SCALE(81))
            make.height.equalTo(WIDTH_SCALE(22))
        }
        let lineView = UILabel()
        lineView.backgroundColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        topBgView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.width.equalTo(statisticsLab)
            make.height.equalTo(WIDTH_SCALE(2))
            make.top.equalTo(statisticsLab.snp.bottom)
            make.centerX.equalTo(statisticsLab)
        }
        
        let realityLab = UILabel.init()
        realityLab.text = "实际出勤天数"
        realityLab.textColor = .white
        realityLab.font = UIFont.fontWith(size: 16)
        topBgView.addSubview(realityLab)
        realityLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(64))
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
        shouldLab.text = "应出勤天数"
        shouldLab.textColor = .white
        shouldLab.font = UIFont.fontWith(size: 11)
        topBgView.addSubview(shouldLab)
        shouldLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(146))
        }
        shouldNumberLab.text = "0"
        shouldNumberLab.textColor = .white
        shouldNumberLab.font = UIFont.fontWith(size: 16)
        topBgView.addSubview(shouldNumberLab)
        shouldNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(shouldLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
//        let abnormalLab = UILabel.init()
//        abnormalLab.text = "异常天数"
//        abnormalLab.textColor = .white
//        abnormalLab.font = UIFont.fontWith(size: 11)
//        topBgView.addSubview(abnormalLab)
//        abnormalLab.snp.makeConstraints { make in
//            make.left.equalTo(shouldLab.snp.right).offset(WIDTH_SCALE(86))
//            make.top.equalToSuperview().offset(WIDTH_SCALE(146))
//        }
//        abnormalNumberLab.text = "30"
//        abnormalNumberLab.textColor = .white
//        abnormalNumberLab.font = UIFont.fontWith(size: 16)
//        topBgView.addSubview(abnormalNumberLab)
//        abnormalNumberLab.snp.makeConstraints { make in
//            make.left.equalTo(abnormalLab.snp.right)
//            make.top.equalTo(abnormalLab.snp.bottom).offset(WIDTH_SCALE(10))
//        }
        
        monthLab.text = "00月"
        monthLab.textColor = .white
        monthLab.font = UIFont.fontWith(size: 60)
        topBgView.addSubview(monthLab)
        monthLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.top.equalToSuperview().offset(WIDTH_SCALE(6))
        }
        
        let bottomBgView = UIView()
        bottomBgView.backgroundColor = .white
        self.addSubview(bottomBgView)
        bottomBgView.snp.makeConstraints { make in
            make.top.equalTo(topBgView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(245))
        }
        
        let earlyLab = UILabel()
        earlyLab.text = "早班次数"
        earlyLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        earlyLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(earlyLab)
        earlyLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        earlyNumberLab.text = "0次"
        earlyNumberLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        earlyNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(earlyNumberLab)
        earlyNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(earlyLab)
        }
        //-------
        let inLab = UILabel()
        inLab.text = "中班次数"
        inLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        inLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(inLab)
        inLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(47))
        }
        inNumberLab.text = "0次"
        inNumberLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        inNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(inNumberLab)
        inNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(inLab)
        }
        //-------
        let nightLab = UILabel()
        nightLab.text = "晚班次数"
        nightLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        nightLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(nightLab)
        nightLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(74))
        }
        nightNumberLab.text = "0次"
        nightNumberLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        nightNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(nightNumberLab)
        nightNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(nightLab)
        }
        //-------
        let workOvertimeLab = UILabel()
        workOvertimeLab.text = "加班天数"
        workOvertimeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        workOvertimeLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(workOvertimeLab)
        workOvertimeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(101))
        }
        workOvertimeNumberLab.text = "0次"
        workOvertimeNumberLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        workOvertimeNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(workOvertimeNumberLab)
        workOvertimeNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(workOvertimeLab)
        }
        //-------
        let festivalAndHolidayLab = UILabel()
        festivalAndHolidayLab.text = "法定节假日出勤天数"
        festivalAndHolidayLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        festivalAndHolidayLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(festivalAndHolidayLab)
        festivalAndHolidayLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(128))
        }
        festivalAndHolidayNumberLab.text = "0次"
        festivalAndHolidayNumberLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        festivalAndHolidayNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(festivalAndHolidayNumberLab)
        festivalAndHolidayNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(festivalAndHolidayLab)
        }
        //-------
        let absencesLab = UILabel()
        absencesLab.text = "缺勤次数"
        absencesLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        absencesLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(absencesLab)
        absencesLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(155))
        }
        absencesNumberLab.text = "0次"
        absencesNumberLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
        absencesNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(absencesNumberLab)
        absencesNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(absencesLab)
        }
        //-------
        
        let leaveEarlyLab = UILabel()
        leaveEarlyLab.text = "早退次数"
        leaveEarlyLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        leaveEarlyLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(leaveEarlyLab)
        leaveEarlyLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(182))
        }
        leaveEarlyNumberLab.text = "0次"
        leaveEarlyNumberLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
        leaveEarlyNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(leaveEarlyNumberLab)
        leaveEarlyNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(leaveEarlyLab)
        }
        //-------
        let missLab = UILabel()
        missLab.text = "迟到次数"
        missLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        missLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(missLab)
        missLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(209))
        }
        missNumberLab.text = "0次"
        missNumberLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
        missNumberLab.font = UIFont.fontWith(size: 12)
        bottomBgView.addSubview(missNumberLab)
        missNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(172))
            make.top.equalTo(missLab)
        }
        //-------
        
        
    }
    
}
