//
//  MyAttendanceCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/15.
//

import UIKit

class MyAttendanceCell: UITableViewCell {
    
    var classesLab = UILabel()
    var classesContenLab = UILabel()
    
    var attendanceLab = UILabel()
    var checkedInLab = UILabel()//已打卡
    var lackOfCards = UILabel()//缺卡或者迟到
    
    
    var modelArr:[MyAttendanceModel] = []{
        didSet {
            clockInDetails(modelArr:modelArr)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        
        classesLab.text = "当日班次："
        classesLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        classesLab.font = UIFont.fontWith(size: 12)
        self.contentView.addSubview(classesLab)
        classesLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        
        classesContenLab.text = "08：00-12：00、14：00-18：00"
        classesContenLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        classesContenLab.font = UIFont.fontWith(size: 12)
        self.contentView.addSubview(classesContenLab)
        classesContenLab.snp.makeConstraints { make in
            make.left.equalTo(classesLab.snp.right).offset(WIDTH_SCALE(1))
            make.centerY.equalTo(classesLab)
        }
        
        attendanceLab.text = "出勤统计："
        attendanceLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        attendanceLab.font = UIFont.fontWith(size: 12)
        self.contentView.addSubview(attendanceLab)
        attendanceLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(classesLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        
        checkedInLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        checkedInLab.font = UIFont.fontWith(size: 12)
        
        self.contentView.addSubview(checkedInLab)
        checkedInLab.snp.makeConstraints { make in
            make.left.equalTo(attendanceLab.snp.right).offset(WIDTH_SCALE(1))
            make.centerY.equalTo(attendanceLab)
        }
    }
    
    func clockInDetails(modelArr:[MyAttendanceModel]) {
        
        for (index,item) in modelArr.enumerated() {
            
            let topDistance = WIDTH_SCALE(12) + WIDTH_SCALE(Float(index*14)) + WIDTH_SCALE(Float(index*13))
            
            let stateLab = UILabel()
            if item.status == 0{
                stateLab.text = "缺卡"
                stateLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
                stateLab.layer.borderColor = YUXICOLOR(h: 0xF5643F, alpha: 1).cgColor
            }else if item.status == 1 {
                stateLab.text = "正常"
                stateLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
                stateLab.layer.borderColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1).cgColor
            }else {
                if item.type == 1 {
                    stateLab.text = "迟到"
                }else {
                    stateLab.text = "早退"
                }
                stateLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
                stateLab.layer.borderColor = YUXICOLOR(h: 0xF5643F, alpha: 1).cgColor
            }
            let stringW = stateLab.text!.getNormalStrW(strFont: WIDTH_SCALE(9), h: WIDTH_SCALE(14))
            stateLab.textAlignment = .center
            stateLab.font = UIFont.fontWith(size: 9)
            stateLab.layer.cornerRadius = WIDTH_SCALE(7)
            stateLab.layer.borderWidth = 1
            
            self.contentView.addSubview(stateLab)
            stateLab.snp.makeConstraints { make in
                make.top.equalTo(attendanceLab.snp.bottom).offset(topDistance)
                make.left.equalToSuperview().offset(WIDTH_SCALE(18))
                make.width.equalTo(stringW+WIDTH_SCALE(8))
                make.height.equalTo(WIDTH_SCALE(14))
            }
            
            let workLab = UILabel()
            if item.type == 1 {
                if item.status == 0{
                    workLab.text = "上班:未打卡"
                }else {
                    workLab.text = "上班:\(item.date)"
                }
            }else {
                if item.status == 0{
                    workLab.text = "下班:未打卡"
                }else {
                    workLab.text = "下班:\(item.date)"
                }
            }
            workLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
            workLab.font = UIFont.fontWith(size: 12)
            self.contentView.addSubview(workLab)
            workLab.snp.makeConstraints { make in
                make.left.equalTo(stateLab.snp.right).offset(WIDTH_SCALE(10))
                make.centerY.equalTo(stateLab)
            }
            
        }
        
        
    }
    
    
}
