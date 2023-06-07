//
//  AttendanceClockInHeaderView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/19.
//

import UIKit

class AttendanceClockInHeaderView: UIView {
    
    var userProfileImagv = UIImageView()
    var userNickLab = UILabel()
    var userGroupingLab = UILabel()
    var userGroupingImagv = UIButton()
    
    var attendanceBgView = UIView()
    var attendanceImage = UIImageView()
    var attendanceLab = UILabel()
    var attendanceTimeLab = UILabel()
    
    var clockInBnt = UIButton()
    
    var tipImage = UIImageView()
    var tipLab = UILabel()
    
    var topBgView = UIView()
    var topTitleLab = UILabel()
    var topLineView = UIView()
    var topCheckedInLab = UILabel()
    
//    var clockInLab1 = UILabel()
//    var stateLab1 = UILabel()
//    var clockInLab2 = UILabel()
//    var stateLab2 = UILabel()
//    var clockInLab3 = UILabel()
//    var stateLab3 = UILabel()
//    var clockInLab4 = UILabel()
//    var stateLab4 = UILabel()
//    var lineV1 = UIView()
//    var lineV2 = UIView()
//    var lineV3 = UIView()
    
    var time:Int = 0
    var qci:Int = 0//未打卡次数
    
    var dataArr:[MyAttendanceModel] = []{
        didSet{
            if dataArr.count == 0 {
                topTitleLab.isHidden = false
            }else {
                topTitleLab.isHidden = true
                setLoopCreationUI(ArrModel: dataArr)
                topCheckedInLab.text = "已打卡 \(time-qci)/\(time)"
            }
        }
    }
    
    var model = AttendanceClockInModel() {
        didSet {
            attendanceTimeLab.text = "上下班时间: \(model.starttime1)-\(model.endtime1) \(model.starttime2)-\(model.endtime2)"
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        
        
        
//        userProfileImagv.image = UIImage(named: "Default_Occupation_Bitmap")
        userProfileImagv.layer.cornerRadius = CGFloat(32*YUXIIPONE_SCALE)
        userProfileImagv.layer.masksToBounds = true
        self.addSubview(userProfileImagv)
        userProfileImagv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalToSuperview().offset(WIDTH_SCALE(13))
            make.width.height.equalTo(WIDTH_SCALE(64))
        }
        
//        userNickLab.text = "Hi,申修智"
        userNickLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        userNickLab.font = UIFont.fontWith(.Semibold, size: WIDTH_SCALE(16))
        userNickLab.textAlignment = .left
        self.addSubview(userNickLab)
        userNickLab.snp.makeConstraints { make in
            make.left.equalTo(userProfileImagv.snp.right).offset(WIDTH_SCALE(10))
            make.top.equalTo(userProfileImagv.snp.top).offset(WIDTH_SCALE(13))
            make.width.lessThanOrEqualTo(WIDTH_SCALE(200))
        }
        
//        userGroupingLab.text = "研发一组"
        userGroupingLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        userGroupingLab.font = UIFont.fontWith(size: WIDTH_SCALE(12))
        userGroupingLab.textAlignment = .left
        self.addSubview(userGroupingLab)
        userGroupingLab.snp.makeConstraints { make in
            make.left.equalTo(userNickLab)
            make.bottom.equalTo(userProfileImagv.snp.bottom).offset(WIDTH_SCALE(-8))
        }
        
        userGroupingImagv.setImage(UIImage(named: "Staging_Grouping"), for: .normal)
        userGroupingImagv.addTarget(self, action: #selector(userGroupingAction), for: .touchUpInside)
        self.addSubview(userGroupingImagv)
        userGroupingImagv.snp.makeConstraints { make in
            make.centerY.equalTo(userGroupingLab)
            make.left.equalTo(userGroupingLab.snp.right).offset(WIDTH_SCALE(10))
            make.width.height.equalTo(WIDTH_SCALE(14))
        }
        
        
        
        
        attendanceBgView.layer.cornerRadius = CGFloat(WIDTH_SCALE(10))
        attendanceBgView.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor//设置阴影的颜色
        attendanceBgView.layer.shadowOpacity = 1//设置阴影的透明度
        attendanceBgView.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        attendanceBgView.layer.shadowRadius = CGFloat(6 * YUXIIPONE_SCALE)//设置阴影的圆角
        attendanceBgView.backgroundColor = .white
        self.addSubview(attendanceBgView)
        attendanceBgView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-10))
            make.height.equalTo(WIDTH_SCALE(85))
            make.left.right.equalToSuperview().inset(WIDTH_SCALE(18))
        }
        attendanceImage.image = UIImage(named: "Attendance_Clock_In_Attendance")
        attendanceBgView.addSubview(attendanceImage)
        attendanceImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(7))
            make.top.equalToSuperview().offset(WIDTH_SCALE(11))
            make.width.height.equalTo(WIDTH_SCALE(16))
        }
        attendanceLab.text = "考勤打卡时间"
        attendanceLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        attendanceLab.font = UIFont.fontWith(size: 16)
        attendanceBgView.addSubview(attendanceLab)
        attendanceLab.snp.makeConstraints { make in
            make.left.equalTo(attendanceImage.snp.right).offset(WIDTH_SCALE(3))
            make.centerY.equalTo(attendanceImage)
        }
        
        attendanceTimeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        attendanceTimeLab.font = UIFont.fontWith(size: 9)
        attendanceBgView.addSubview(attendanceTimeLab)
        attendanceTimeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(5))
            make.top.equalTo(attendanceImage.snp.bottom).offset(WIDTH_SCALE(12))
        }
        
        //-----
        clockInBnt.setBackgroundImage(UIImage.init(named: "Attendance_Clock_In_Button_bg"), for: .normal)
        clockInBnt.backgroundColor = .clear
        clockInBnt.titleLabel?.numberOfLines = 2
        clockInBnt.titleLabel?.textAlignment = .center
//        clockInBnt.setTitle("上班打卡\n24：08：08", for: .normal)
        clockInBnt.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        clockInBnt.titleLabel?.font = UIFont.fontWith(size: 20)
        self.addSubview(clockInBnt)
        clockInBnt.snp.makeConstraints { make in
            make.bottom.equalTo(attendanceBgView.snp.top).offset(WIDTH_SCALE(-80))
            make.centerX.equalToSuperview()
            make.width.height.equalTo(WIDTH_SCALE(174))
        }
        
        tipLab.text = "已进入考勤范围，请点击按钮拍照打卡"
        tipLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        tipLab.font = UIFont.fontWith(size: 9)
        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.top.equalTo(clockInBnt.snp.bottom).offset(WIDTH_SCALE(25))
            make.centerX.equalToSuperview().offset(WIDTH_SCALE(12))
        }
        tipImage.image = UIImage(named: "Attendance_Clock_In_Locate")
        self.addSubview(tipImage)
        tipImage.snp.makeConstraints { make in
            make.centerY.equalTo(tipLab)
            make.right.equalTo(tipLab.snp.left).offset(WIDTH_SCALE(-1))
            make.width.height.equalTo(WIDTH_SCALE(12))
        }
        
        topBgView.backgroundColor = YUXICOLOR(h: 0xFFFFFF, alpha: 0.7)
        topBgView.layer.cornerRadius = CGFloat(WIDTH_SCALE(28))
        topBgView.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor//设置阴影的颜色
        topBgView.layer.shadowOpacity = 1//设置阴影的透明度
        topBgView.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        topBgView.layer.shadowRadius = CGFloat(6 * YUXIIPONE_SCALE)//设置阴影的圆角
        self.addSubview(topBgView)
        topBgView.snp.makeConstraints { make in
            make.bottom.equalTo(clockInBnt.snp.top).offset(WIDTH_SCALE(-30))
            make.height.equalTo(WIDTH_SCALE(56))
            make.left.right.equalToSuperview().inset(WIDTH_SCALE(18))
        }
        
        topTitleLab.text = "美好的一天开始啦！"
        topTitleLab.isHidden = true
        topTitleLab.textColor = YUXICOLOR(h: 0x666666, alpha: 1)
        topTitleLab.font = UIFont.fontWith(size: 16)
        topBgView.addSubview(topTitleLab)
        topTitleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(10))
            make.centerY.equalToSuperview()
        }
        
        
        topLineView.backgroundColor = YUXICOLOR(h: 0xE4E4E4, alpha: 1)
        topBgView.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.height.equalTo(WIDTH_SCALE(39.5))
            make.width.equalTo(WIDTH_SCALE(1))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(WIDTH_SCALE(-70))
        }
        
        topCheckedInLab.textColor = YUXICOLOR(h: 0x666666, alpha: 1)
        topCheckedInLab.font = UIFont.fontWith(size: 10)
        topBgView.addSubview(topCheckedInLab)
        topCheckedInLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(WIDTH_SCALE(-10))
        }
        
        
    }
    
    @objc func userGroupingAction() {
        let vc = MessageCenterViewController()
        UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setLoopCreationUI(ArrModel:[MyAttendanceModel]){
        
        for (index,model) in ArrModel.enumerated() {
            let distance = CGFloat(index)*WIDTH_SCALE(68)
            
            if let view = self.viewWithTag(1000+index) {
                view.removeFromSuperview()
            }
            if let label = self.viewWithTag(2000+index) as? UILabel {
                label.removeFromSuperview()
            }
            if let label = self.viewWithTag(3000+index) as? UILabel {
                label.removeFromSuperview()
            }
            
            let lineV = UIView()
            lineV.backgroundColor = YUXICOLOR(h: 0xE4E4E4, alpha: 1)
            lineV.tag = 1000 + index
            topBgView.addSubview(lineV)
            lineV.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(distance)
                make.height.equalTo(WIDTH_SCALE(39.5))
                make.width.equalTo(WIDTH_SCALE(1))
            }
            let clockInLab = UILabel()
            if model.type == 1 {
                clockInLab.text = "上班 \(model.date)"
            }else {
                clockInLab.text = "下班 \(model.date)"
            }
            clockInLab.tag = 2000 + index
            clockInLab.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
            clockInLab.font = UIFont.fontWith(size: 10)
            topBgView.addSubview(clockInLab)
            clockInLab.snp.makeConstraints { make in
                if index == 0 {
                    make.left.equalTo(lineV.snp.right).offset(WIDTH_SCALE(10))
                }else{
                    make.left.equalTo(lineV.snp.right).offset(WIDTH_SCALE(3))
                }
                make.top.equalToSuperview().offset(WIDTH_SCALE(12))
            }
            let stateLab = UILabel()
            stateLab.tag = 3000 + index
            if model.status == 0 {
                stateLab.text = "未打卡"
                stateLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
            }else if model.status == 1{
                stateLab.text = "已打卡"
                stateLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
            }else {
                if model.type == 1 {
                    stateLab.text = "迟到"
                }else {
                    stateLab.text = "早退"
                }
                stateLab.textColor = YUXICOLOR(h: 0xF5643F, alpha: 1)
            }
            stateLab.font = UIFont.fontWith(size: 9)
            topBgView.addSubview(stateLab)
            stateLab.snp.makeConstraints { make in
                make.left.equalTo(clockInLab)
                make.top.equalTo(clockInLab.snp.bottom).offset(WIDTH_SCALE(5))
            }
            
            
            if index == 0 {
                lineV.isHidden = true
            }else {
                lineV.isHidden = false
            }
            
        }
        
    }
    
}
