//
//  SalaryDetailsCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit

class SalaryDetailsCell: UITableViewCell {
    
    var titleLab = UILabel()
    var unitLab = UILabel()
    
    
    var basicNumberLab = UILabel()//基本工资
    var performanceNumberLab = UILabel()//绩效
    var bonusNumberLab = UILabel()//班组长津贴
    var workOvertimeSNumberLab = UILabel()//加班工资
    var educationSalaryNumberLab = UILabel()//职称学历工资
    var seniorityPayNumberLab = UILabel()//工龄工资
    var dutyAllowanceNumberLab = UILabel()//24小时值班补贴
    var wellEntryAllowanceNumberLab = UILabel()//入井津贴
    var middleShiftSubsidyNumberLab = UILabel()//中班补贴
    var nightShiftSubsidyNumberLab = UILabel()//夜班补贴
    var statutoryHolidayWagesNumberLab = UILabel()//法定节假日工资
    var commuterSubsidiesNumberLab = UILabel()//通勤补贴
    var driverDrivingSubsidyNumberLab = UILabel()//司机出车补贴
    var leagueSecretaryNumberLab = UILabel()//团委书记补贴
    var villageSubsidyNumberLab = UILabel()//驻村补贴
    var coalStorageNumberLab = UILabel()//煤炭库前移驻外补
    var otherSubsidiesNumberLab = UILabel()//其他补贴
    var securedAccountNumberLab = UILabel()//安全账户
    var gasNumberLab = UILabel()//瓦斯风险抵押金
    
    
    
    
    var welfareNumberLab = UILabel()//养老保险
    
    var deductionsNumberLab = UILabel()//医疗保险
    
    var unemploymentNumberLab = UILabel()//失业保险
    
    var incomeTaxNumberLab = UILabel()//个人所得
    
    var socialSecurityNumberLab = UILabel()//大病医疗保险
    
    var otherDeductionsNumberLab = UILabel()//住房公积金
    var totalLab = UILabel()
    var totalNumberLab = UILabel()
    
    
    var model = MySalaryDetailsModel(){
        didSet {
//            basicNumberLab.text = "\(model.yf_value)"//基本工资
            performanceNumberLab.text = model.gwjx_value//绩效
            bonusNumberLab.text = model.bzz_value//班组长津贴
            workOvertimeSNumberLab.text = model.jb_value
            educationSalaryNumberLab.text = model.xl_value
            seniorityPayNumberLab.text = model.gl_value
            dutyAllowanceNumberLab.text = model.duty_value
            wellEntryAllowanceNumberLab.text = model.rj_value
            middleShiftSubsidyNumberLab.text = model.zb_value
            nightShiftSubsidyNumberLab.text = model.yb_value
            statutoryHolidayWagesNumberLab.text = model.holiday_value
            commuterSubsidiesNumberLab.text = model.tqbt
            driverDrivingSubsidyNumberLab.text = model.driver_value
            leagueSecretaryNumberLab.text = model.tzb_value
            villageSubsidyNumberLab.text = model.zc_value
            coalStorageNumberLab.text = model.mtk_value
            otherSubsidiesNumberLab.text = model.qt_value
            securedAccountNumberLab.text = model.aqzh_value
            gasNumberLab.text = model.wsfx_value
            
            
            welfareNumberLab.text = model.per1//养老保险
            deductionsNumberLab.text = model.per2//医疗保险
            unemploymentNumberLab.text = model.per3//失业保险
            incomeTaxNumberLab.text = model.per12//个人所得税
            socialSecurityNumberLab.text = model.per4//大病医疗保险
            otherDeductionsNumberLab.text = model.per11//住房公积金
//            totalNumberLab.text = model.sf_value//总计
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {

        
        titleLab.text = "收入项"
        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(.Semibold, size: 20)
        self.contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        let lineView = UIView()
        lineView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(2))
            make.width.equalTo(WIDTH_SCALE(60))
        }
        unitLab.text = "(单位:元)"
        unitLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        unitLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(unitLab)
        unitLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab.snp.right)
            make.centerY.equalTo(titleLab)
        }
        let basicLab = UILabel()
        basicLab.isHidden = true
        basicLab.text = "基本工资"
        basicLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        basicLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(basicLab)
        basicLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(titleLab.snp.bottom).offset(WIDTH_SCALE(20))
        }
        basicNumberLab.text = "0"
        basicNumberLab.isHidden = true
        basicNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        basicNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(basicNumberLab)
        basicNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(basicLab)
        }
        
        //1---------
        let performanceLab = UILabel()
        performanceLab.text = "岗位绩效工资考核金额"
        performanceLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        performanceLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(performanceLab)
        performanceLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(titleLab.snp.bottom).offset(WIDTH_SCALE(20))
        }
        performanceNumberLab.text = "0"
        performanceNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        performanceNumberLab.font = UIFont.fontWith(size: 16)
        performanceNumberLab.textAlignment = .left
        self.contentView.addSubview(performanceNumberLab)
        performanceNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(performanceLab)
        }
        
        
        
        let workOvertimeSLab = UILabel()
        workOvertimeSLab.text = "加班工资"
        workOvertimeSLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        workOvertimeSLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(workOvertimeSLab)
        workOvertimeSLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(performanceLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        workOvertimeSNumberLab.text = "0"
        workOvertimeSNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        workOvertimeSNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(workOvertimeSNumberLab)
        workOvertimeSNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(workOvertimeSLab)
        }
        let educationSalaryLab = UILabel()
        educationSalaryLab.text = "职称学历工资"
        educationSalaryLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        educationSalaryLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(educationSalaryLab)
        educationSalaryLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(workOvertimeSLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        educationSalaryNumberLab.text = "0"
        educationSalaryNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        educationSalaryNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(educationSalaryNumberLab)
        educationSalaryNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(educationSalaryLab)
        }
        let seniorityPayLab = UILabel()
        seniorityPayLab.text = "工龄工资"
        seniorityPayLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        seniorityPayLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(seniorityPayLab)
        seniorityPayLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(educationSalaryLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        seniorityPayNumberLab.text = "0"
        seniorityPayNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        seniorityPayNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(seniorityPayNumberLab)
        seniorityPayNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(seniorityPayLab)
        }
        
        let dutyAllowanceLab = UILabel()
        dutyAllowanceLab.text = "部门24小时值班补贴"
        dutyAllowanceLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        dutyAllowanceLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(dutyAllowanceLab)
        dutyAllowanceLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(seniorityPayLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        dutyAllowanceNumberLab.text = "0"
        dutyAllowanceNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        dutyAllowanceNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(dutyAllowanceNumberLab)
        dutyAllowanceNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(dutyAllowanceLab)
        }
        
        let wellEntryAllowanceLab = UILabel()
        wellEntryAllowanceLab.text = "入井津贴"
        wellEntryAllowanceLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        wellEntryAllowanceLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(wellEntryAllowanceLab)
        wellEntryAllowanceLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(dutyAllowanceLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        wellEntryAllowanceNumberLab.text = "0"
        wellEntryAllowanceNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        wellEntryAllowanceNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(wellEntryAllowanceNumberLab)
        wellEntryAllowanceNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(wellEntryAllowanceLab)
        }
        
        let middleShiftSubsidyLab = UILabel()
        middleShiftSubsidyLab.text = "中班补贴"
        middleShiftSubsidyLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        middleShiftSubsidyLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(middleShiftSubsidyLab)
        middleShiftSubsidyLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(wellEntryAllowanceLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        middleShiftSubsidyNumberLab.text = "0"
        middleShiftSubsidyNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        middleShiftSubsidyNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(middleShiftSubsidyNumberLab)
        middleShiftSubsidyNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(middleShiftSubsidyLab)
        }
        
        let nightShiftSubsidyLab = UILabel()
        nightShiftSubsidyLab.text = "夜班补贴"
        nightShiftSubsidyLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        nightShiftSubsidyLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(nightShiftSubsidyLab)
        nightShiftSubsidyLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(middleShiftSubsidyLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        nightShiftSubsidyNumberLab.text = "0"
        nightShiftSubsidyNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        nightShiftSubsidyNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(nightShiftSubsidyNumberLab)
        nightShiftSubsidyNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(nightShiftSubsidyLab)
        }
        
        //2---------
        let bonusLab = UILabel()
        bonusLab.text = "班组长津贴"
        bonusLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        bonusLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(bonusLab)
        bonusLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(nightShiftSubsidyLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        bonusNumberLab.text = "99999"
        bonusNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        bonusNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(bonusNumberLab)
        bonusNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(bonusLab)
        }
        
        let commuterSubsidiesLab = UILabel()
        commuterSubsidiesLab.text = "通勤补贴"
        commuterSubsidiesLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        commuterSubsidiesLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(commuterSubsidiesLab)
        commuterSubsidiesLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(bonusLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        commuterSubsidiesNumberLab.text = "0"
        commuterSubsidiesNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        commuterSubsidiesNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(commuterSubsidiesNumberLab)
        commuterSubsidiesNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(commuterSubsidiesLab)
        }
        
        let statutoryHolidayWagesLab = UILabel()
        statutoryHolidayWagesLab.text = "法定节假日工资"
        statutoryHolidayWagesLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        statutoryHolidayWagesLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(statutoryHolidayWagesLab)
        statutoryHolidayWagesLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(commuterSubsidiesLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        statutoryHolidayWagesNumberLab.text = "0"
        statutoryHolidayWagesNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        statutoryHolidayWagesNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(statutoryHolidayWagesNumberLab)
        statutoryHolidayWagesNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(statutoryHolidayWagesLab)
        }
        
        
        
        let driverDrivingSubsidyLab = UILabel()
        driverDrivingSubsidyLab.text = "司机出车补贴"
        driverDrivingSubsidyLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        driverDrivingSubsidyLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(driverDrivingSubsidyLab)
        driverDrivingSubsidyLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(statutoryHolidayWagesLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        driverDrivingSubsidyNumberLab.text = "0"
        driverDrivingSubsidyNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        driverDrivingSubsidyNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(driverDrivingSubsidyNumberLab)
        driverDrivingSubsidyNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(driverDrivingSubsidyLab)
        }
        
        let leagueSecretaryLab = UILabel()
        leagueSecretaryLab.text = "团委书记补贴"
        leagueSecretaryLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        leagueSecretaryLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(leagueSecretaryLab)
        leagueSecretaryLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(driverDrivingSubsidyLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        leagueSecretaryNumberLab.text = "0"
        leagueSecretaryNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        leagueSecretaryNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(leagueSecretaryNumberLab)
        leagueSecretaryNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(leagueSecretaryLab)
        }
        
        let villageSubsidyLab = UILabel()
        villageSubsidyLab.text = "驻村补贴"
        villageSubsidyLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        villageSubsidyLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(villageSubsidyLab)
        villageSubsidyLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(leagueSecretaryLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        villageSubsidyNumberLab.text = "0"
        villageSubsidyNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        villageSubsidyNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(villageSubsidyNumberLab)
        villageSubsidyNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(villageSubsidyLab)
        }
        
        let coalStorageLab = UILabel()
        coalStorageLab.text = "煤炭库前移驻外补"
        coalStorageLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        coalStorageLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(coalStorageLab)
        coalStorageLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(villageSubsidyLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        coalStorageNumberLab.text = "0"
        coalStorageNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        coalStorageNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(coalStorageNumberLab)
        coalStorageNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(coalStorageLab)
        }
        
        let otherSubsidiesLab = UILabel()
        otherSubsidiesLab.text = "其他补贴"
        otherSubsidiesLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        otherSubsidiesLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(otherSubsidiesLab)
        otherSubsidiesLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(coalStorageLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        otherSubsidiesNumberLab.text = "0"
        otherSubsidiesNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        otherSubsidiesNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(otherSubsidiesNumberLab)
        otherSubsidiesNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(otherSubsidiesLab)
        }
        
        let securedAccountLab = UILabel()
        securedAccountLab.text = "安全账户"
        securedAccountLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        securedAccountLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(securedAccountLab)
        securedAccountLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(otherSubsidiesLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        securedAccountNumberLab.text = "0"
        securedAccountNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        securedAccountNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(securedAccountNumberLab)
        securedAccountNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(securedAccountLab)
        }
        
        let gasLab = UILabel()
        gasLab.text = "瓦斯风险抵押金"
        gasLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        gasLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(gasLab)
        gasLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(securedAccountLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        gasNumberLab.text = "0"
        gasNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        gasNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(gasNumberLab)
        gasNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(gasLab)
        }
        
        let withholdLab = UILabel()
        withholdLab.text = "公司代扣"
        withholdLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        withholdLab.font = UIFont.fontWith(.Semibold, size: 20)
        self.contentView.addSubview(withholdLab)
        withholdLab.snp.makeConstraints { make in
            make.top.equalTo(gasLab.snp.bottom).offset(WIDTH_SCALE(20))
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.width.equalTo(WIDTH_SCALE(81))
            make.height.equalTo(WIDTH_SCALE(28))
        }
        let lineView2 = UIView()
        lineView2.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.contentView.addSubview(lineView2)
        lineView2.snp.makeConstraints { make in
            make.centerX.equalTo(withholdLab)
            make.top.equalTo(withholdLab.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(2))
            make.width.equalTo(WIDTH_SCALE(82))
        }
        
        
        //3---------
        let welfareLab = UILabel()
        welfareLab.text = "养老保险"
        welfareLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        welfareLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(welfareLab)
        welfareLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(withholdLab.snp.bottom).offset(WIDTH_SCALE(20))
        }
        welfareNumberLab.text = "0"
        welfareNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        welfareNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(welfareNumberLab)
        welfareNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(welfareLab)
        }
        
        //4---------
        let deductionsLab = UILabel()
        deductionsLab.text = "医疗保险"
        deductionsLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        deductionsLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(deductionsLab)
        deductionsLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(welfareLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        deductionsNumberLab.text = "0"
        deductionsNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        deductionsNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(deductionsNumberLab)
        deductionsNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(deductionsLab)
        }
        
        let unemploymentLab = UILabel()
        unemploymentLab.text = "失业保险"
        unemploymentLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        unemploymentLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(unemploymentLab)
        unemploymentLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(deductionsLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        unemploymentNumberLab.text = "0"
        unemploymentNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        unemploymentNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(unemploymentNumberLab)
        unemploymentNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(unemploymentLab)
        }
        
        //5---------
        let incomeTaxLab = UILabel()
        incomeTaxLab.text = "个人所得税"
        incomeTaxLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        incomeTaxLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(incomeTaxLab)
        incomeTaxLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(unemploymentLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        incomeTaxNumberLab.text = "0"
        incomeTaxNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        incomeTaxNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(incomeTaxNumberLab)
        incomeTaxNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(incomeTaxLab)
        }
        
        //6---------
        let socialSecurityLab = UILabel()
        socialSecurityLab.text = "大病医疗保险"
        socialSecurityLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        socialSecurityLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(socialSecurityLab)
        socialSecurityLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(incomeTaxLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        socialSecurityNumberLab.text = "0"
        socialSecurityNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        socialSecurityNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(socialSecurityNumberLab)
        socialSecurityNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(socialSecurityLab)
        }
        
        //7---------
        let otherDeductionsLab = UILabel()
        otherDeductionsLab.text = "住房公积金"
        otherDeductionsLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        otherDeductionsLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(otherDeductionsLab)
        otherDeductionsLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalTo(socialSecurityLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        otherDeductionsNumberLab.text = "0"
        otherDeductionsNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
        otherDeductionsNumberLab.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(otherDeductionsNumberLab)
        otherDeductionsNumberLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(155))
            make.centerY.equalTo(otherDeductionsLab)
        }
        
        //8---------
//        totalLab.text = "总计收入"
//        totalLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
//        totalLab.font = UIFont.fontWith(size: 16)
//        self.contentView.addSubview(totalLab)
//        totalLab.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(WIDTH_SCALE(20))
//            make.top.equalTo(otherDeductionsLab.snp.bottom).offset(WIDTH_SCALE(10))
//        }
//        totalNumberLab.text = "0"
//        totalNumberLab.textColor = YUXICOLOR(h: 0x444444, alpha: 1)
//        totalNumberLab.font = UIFont.fontWith(size: 16)
//        self.contentView.addSubview(totalNumberLab)
//        totalNumberLab.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(WIDTH_SCALE(-20))
//            make.width.equalTo(WIDTH_SCALE(155))
//            make.centerY.equalTo(totalLab)
//        }
        
    }

}
