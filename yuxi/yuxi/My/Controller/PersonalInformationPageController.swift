//
//  PersonalInformationPageController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit
import SwiftyJSON

class PersonalInformationPageController: YUXIBaseController {
    
    var userHeadImag = UIImageView()
    var userNickLab = UILabel()
    var positionLab = UILabel()
    var jobNumberLab = UILabel()
    var lineView = UIView()
    
    var phoneLab = UILabel()
    var phonNumberLab = UILabel()
    
    var mailboxLab = UILabel()
    var mailboxNumberLab = UILabel()
    
    var departmentLab = UILabel()
    var departmentNumberLab = UILabel()
    
    var seniorityLab = UILabel()
    var seniorityNumberLab = UILabel()
    
    var entryTimeLab = UILabel()
    var entryTimeNumberLab = UILabel()
    
    var model = PersonalInformationPageModel(){
        didSet {
            if let profile = UserInfo.mr_findFirst()?.avatar {
                userHeadImag.sd_setImage(with: URL.init(string: PYADDRESS_URL + profile))
            }
            if let number = UserInfo.mr_findFirst()?.number {
                jobNumberLab.text = "工号:\(number)"
            }
            userNickLab.text = model.username
            phonNumberLab.text = model.phone
            departmentNumberLab.text = model.department
            positionLab.text = model.position
            mailboxNumberLab.text = model.email
            seniorityNumberLab.text = model.work_age
            entryTimeNumberLab.text = model.entry_date
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let topBg = UIImageView.init(image: UIImage(named: "Personal_Information_Top_Bg"))
        self.view.addSubview(topBg)
        topBg.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(133))
        }
        
        
        self.YUXICreateNavbar(navTitle: "", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.isNavBarClear = true
        self.view.backgroundColor = .white
        
        setUI()
        getURLUserInfoRequset()
    }
    
    func setUI() {
//        userHeadImag.image = UIImage(named: "Default_Occupation_Bitmap")
        userHeadImag.layer.cornerRadius = CGFloat(WIDTH_SCALE(131/2))
        userHeadImag.layer.masksToBounds = true
        self.view.addSubview(userHeadImag)
        userHeadImag.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(118))
            make.centerX.equalToSuperview()
            make.width.height.equalTo(WIDTH_SCALE(131))
        }
        
        userNickLab.text = "----"
        userNickLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        userNickLab.font = UIFont.fontWith(.Semibold, size: 20)
        userNickLab.textAlignment = .center
        self.view.addSubview(userNickLab)
        userNickLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userHeadImag.snp.bottom).offset(WIDTH_SCALE(20))
        }
        
        lineView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 0.5)
        self.view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNickLab.snp.bottom).offset(WIDTH_SCALE(21))
            make.height.equalTo(WIDTH_SCALE(15))
            make.width.equalTo(WIDTH_SCALE(2))
        }
        
        
        positionLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        positionLab.font = UIFont.fontWith(size: 12)
        self.view.addSubview(positionLab)
        positionLab.snp.makeConstraints { make in
            make.right.equalTo(lineView.snp.left).offset(WIDTH_SCALE(-10))
            make.centerY.equalTo(lineView)
        }
        
        jobNumberLab.text = "工号:"
        jobNumberLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        jobNumberLab.font = UIFont.fontWith( size: 12)
        self.view.addSubview(jobNumberLab)
        jobNumberLab.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(WIDTH_SCALE(10))
            make.centerY.equalTo(lineView)
        }
        
        phoneLab.text = "手机"
        phoneLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        phoneLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(phoneLab)
        phoneLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(lineView.snp.bottom).offset(WIDTH_SCALE(21))
        }
//        phonNumberLab.text = "888888888"
        phonNumberLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        phonNumberLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(phonNumberLab)
        phonNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(130))
            make.centerY.equalTo(phoneLab)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
        }
        //------
        mailboxLab.text = "邮箱"
        mailboxLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        mailboxLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(mailboxLab)
        mailboxLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(phoneLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
//        mailboxNumberLab.text = "888888888"
        mailboxNumberLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        mailboxNumberLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(mailboxNumberLab)
        mailboxNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(130))
            make.centerY.equalTo(mailboxLab)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
        }
        //------
        departmentLab.text = "部门"
        departmentLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        departmentLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(departmentLab)
        departmentLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(mailboxLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
//        departmentNumberLab.text = "部门"
        departmentNumberLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        departmentNumberLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(departmentNumberLab)
        departmentNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(130))
            make.centerY.equalTo(departmentLab)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
        }
        //------
        seniorityLab.text = "工龄"
        seniorityLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        seniorityLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(seniorityLab)
        seniorityLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(departmentLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
        seniorityNumberLab.text = "8.5年"
        seniorityNumberLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        seniorityNumberLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(seniorityNumberLab)
        seniorityNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(130))
            make.centerY.equalTo(seniorityLab)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
        }
        //------
        entryTimeLab.text = "入职时间"
        entryTimeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        entryTimeLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(entryTimeLab)
        entryTimeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(seniorityLab.snp.bottom).offset(WIDTH_SCALE(10))
        }
//        entryTimeNumberLab.text = "888-88-88"
        entryTimeNumberLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        entryTimeNumberLab.font = UIFont.fontWith( size: 16)
        self.view.addSubview(entryTimeNumberLab)
        entryTimeNumberLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(130))
            make.centerY.equalTo(entryTimeLab)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
        }
        //------
    }
    
    //获取用户信息
    func getURLUserInfoRequset() {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number] as [String : Any]
            let checkParms = [number]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_User_Info, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_User_Info:\(json)")
                    
                    let content = json["data"]
                    let code = json["code"].intValue
//                    let msg = json["msg"].stringValue
                    if code == 200 {
                        weakself.model = PersonalInformationPageModel.getUserdepData(json: content)
                    }else{
                        
                    }
                    
                }
            } err: {[weak self] error in
                Dprint("URL_User_Info====== \(error)")
                self?.view.hideToastActivity()
            }
        }
    }
    

}
