//
//  StagingViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/28.
//

import UIKit


class StagingViewController: YUXIBaseController {
    
    let bgImagv = UIImageView()
    
    var userProfileImagv = UIImageView()
    var userNickLab = UILabel()
    var userGroupingLab = UILabel()
    var userGroupingImagv = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bgImagv.image = UIImage(named: "Staging_Bg")
        bgImagv.isUserInteractionEnabled = true
        self.view.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.YUXICreateNavbarLeft(navTitle: "玉溪人力资源", navTitleColorIsWidth: false)
//        self.YUXICreateNavbar(navTitle: "山西兰花科技", leftImage: "", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
//        self.isHiddenBackBtn = true
        // Do any additional setup after loading the view.
        
        
//        userProfileImagv.image = UIImage(named: "Default_Occupation_Bitmap")
        
        userProfileImagv.layer.cornerRadius = CGFloat(32*YUXIIPONE_SCALE)
        userProfileImagv.layer.masksToBounds = true
        bgImagv.addSubview(userProfileImagv)
        userProfileImagv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(navBarV.snp.bottom).offset(WIDTH_SCALE(13))
            make.width.height.equalTo(WIDTH_SCALE(64))
        }
        
//        userNickLab.text = "Hi,申修智"
        
        userNickLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        userNickLab.font = UIFont.fontWith(.Semibold, size: WIDTH_SCALE(16))
        userNickLab.textAlignment = .left
        bgImagv.addSubview(userNickLab)
        userNickLab.snp.makeConstraints { make in
            make.left.equalTo(userProfileImagv.snp.right).offset(WIDTH_SCALE(10))
            make.top.equalTo(userProfileImagv.snp.top).offset(WIDTH_SCALE(13))
            make.width.lessThanOrEqualTo(WIDTH_SCALE(200))
        }
        
//        userGroupingLab.text = "研发一组"
        
        userGroupingLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        userGroupingLab.font = UIFont.fontWith(size: WIDTH_SCALE(12))
        userGroupingLab.textAlignment = .left
        bgImagv.addSubview(userGroupingLab)
        userGroupingLab.snp.makeConstraints { make in
            make.left.equalTo(userNickLab)
            make.bottom.equalTo(userProfileImagv.snp.bottom).offset(WIDTH_SCALE(-8))
        }
        
        userGroupingImagv.setImage( UIImage(named: "Staging_Grouping"), for: .normal)
        userGroupingImagv.addTarget(self, action: #selector(clickToSelect(sender:)), for: .touchUpInside)
        userGroupingImagv.tag = 1
        bgImagv.addSubview(userGroupingImagv)
        userGroupingImagv.snp.makeConstraints { make in
            make.centerY.equalTo(userGroupingLab)
            make.left.equalTo(userGroupingLab.snp.right).offset(WIDTH_SCALE(10))
            make.width.height.equalTo(WIDTH_SCALE(14))
        }
        
        let addressBgview = UIView()
        addressBgview.layer.cornerRadius = CGFloat(WIDTH_SCALE(10))
        addressBgview.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor//设置阴影的颜色
        addressBgview.layer.shadowOpacity = 1//设置阴影的透明度
        addressBgview.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        addressBgview.layer.shadowRadius = CGFloat(6 * YUXIIPONE_SCALE);//设置阴影的圆角
        addressBgview.backgroundColor = .white
        bgImagv.addSubview(addressBgview)
        addressBgview.snp.makeConstraints { make in
            make.top.equalTo(userProfileImagv.snp.bottom).offset(WIDTH_SCALE(67))
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.right.equalTo(bgImagv.snp.centerX).offset(WIDTH_SCALE(-4.5))
            make.height.equalTo(WIDTH_SCALE(189))
            make.width.equalTo(WIDTH_SCALE(165))
        }
        let addressBtn = UIButton.init(type: .custom)
        addressBtn.tag = 0
        addressBtn.addTarget(self, action: #selector(clickToSelect(sender:)), for: .touchUpInside)
        addressBtn.setImage(UIImage(named: "Staging_Address_Book"), for: .normal)
        addressBgview.addSubview(addressBtn)
        addressBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-30))
            make.width.equalTo(WIDTH_SCALE(143))
            make.height.equalTo(WIDTH_SCALE(149))
        }
        let addressLab = UILabel()
        addressLab.text = "通讯录"
        addressLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        addressLab.textAlignment = .center
        addressLab.font = UIFont.fontWith(size: 16)
        addressBgview.addSubview(addressLab)
        addressLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.centerX.equalToSuperview()
        }
        //---------
        let messageBgview = UIView()
        messageBgview.layer.cornerRadius = CGFloat(WIDTH_SCALE(10))
        messageBgview.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor//设置阴影的颜色
        messageBgview.layer.shadowOpacity = 1//设置阴影的透明度
        messageBgview.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        messageBgview.layer.shadowRadius = CGFloat(6 * YUXIIPONE_SCALE);//设置阴影的圆角
        messageBgview.backgroundColor = .white
        bgImagv.addSubview(messageBgview)
        messageBgview.snp.makeConstraints { make in
            make.top.equalTo(addressBgview)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.left.equalTo(bgImagv.snp.centerX).offset(WIDTH_SCALE(4.5))
            make.height.equalTo(WIDTH_SCALE(189))
            make.width.equalTo(WIDTH_SCALE(165))
        }
        let messageBtn = UIButton.init(type: .custom)
        messageBtn.tag = 1
        messageBtn.addTarget(self, action: #selector(clickToSelect(sender:)), for: .touchUpInside)
        messageBtn.setImage(UIImage(named: "Staging_Message_Center"), for: .normal)
        messageBgview.addSubview(messageBtn)
        messageBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-30))
            make.width.equalTo(WIDTH_SCALE(143))
            make.height.equalTo(WIDTH_SCALE(149))
        }
        let messageLab = UILabel()
        messageLab.text = "消息中心"
        messageLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        messageLab.textAlignment = .center
        messageLab.font = UIFont.fontWith(size: 16)
        messageBgview.addSubview(messageLab)
        messageLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.centerX.equalToSuperview()
        }
        
        let employeeBgview = UIView()
        employeeBgview.layer.cornerRadius = CGFloat(WIDTH_SCALE(10))
        employeeBgview.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor//设置阴影的颜色
        employeeBgview.layer.shadowOpacity = 1//设置阴影的透明度
        employeeBgview.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        employeeBgview.layer.shadowRadius = CGFloat(6 * YUXIIPONE_SCALE);//设置阴影的圆角
        employeeBgview.backgroundColor = .white
        bgImagv.addSubview(employeeBgview)
        employeeBgview.snp.makeConstraints { make in
            make.top.equalTo(addressBgview.snp.bottom).offset(WIDTH_SCALE(10))
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.right.equalTo(bgImagv.snp.centerX).offset(WIDTH_SCALE(-4.5))
            make.height.equalTo(WIDTH_SCALE(189))
            make.width.equalTo(WIDTH_SCALE(165))
        }
        let employeeBtn = UIButton.init(type: .custom)
        employeeBtn.tag = 2
        employeeBtn.addTarget(self, action: #selector(clickToSelect(sender:)), for: .touchUpInside)
        employeeBtn.setImage(UIImage(named: "Staging_Employee_Statistics"), for: .normal)
        employeeBgview.addSubview(employeeBtn)
        employeeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-30))
            make.width.equalTo(WIDTH_SCALE(145))
            make.height.equalTo(WIDTH_SCALE(151))
        }
        let employeeLab = UILabel()
        employeeLab.text = "员工统计"
        employeeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        employeeLab.textAlignment = .center
        employeeLab.font = UIFont.fontWith(size: 16)
        employeeBgview.addSubview(employeeLab)
        employeeLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.centerX.equalToSuperview()
        }
        
        //--------
        let salaryBgview = UIView()
        salaryBgview.layer.cornerRadius = CGFloat(WIDTH_SCALE(10))
        salaryBgview.layer.shadowColor = YUXICOLOR(h: 0xAADBFE, alpha: 1).cgColor//设置阴影的颜色
        salaryBgview.layer.shadowOpacity = 1//设置阴影的透明度
        salaryBgview.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        salaryBgview.layer.shadowRadius = CGFloat(6 * YUXIIPONE_SCALE);//设置阴影的圆角
        salaryBgview.backgroundColor = .white
        bgImagv.addSubview(salaryBgview)
        salaryBgview.snp.makeConstraints { make in
            make.top.equalTo(employeeBgview)
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.left.equalTo(bgImagv.snp.centerX).offset(WIDTH_SCALE(4.5))
            make.height.equalTo(WIDTH_SCALE(189))
            make.width.equalTo(WIDTH_SCALE(165))
        }
        let salaryBtn = UIButton.init(type: .custom)
        salaryBtn.tag = 3
        salaryBtn.addTarget(self, action: #selector(clickToSelect(sender:)), for: .touchUpInside)
        salaryBtn.setImage(UIImage(named: "Staging_Salary_Statistics"), for: .normal)
        salaryBgview.addSubview(salaryBtn)
        salaryBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-30))
            make.width.equalTo(WIDTH_SCALE(145))
            make.height.equalTo(WIDTH_SCALE(134))
        }
        let salaryLab = UILabel()
        salaryLab.text = "薪资统计"
        salaryLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        salaryLab.textAlignment = .center
        salaryLab.font = UIFont.fontWith(size: 16)
        salaryBgview.addSubview(salaryLab)
        salaryLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.centerX.equalToSuperview()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let profile = UserInfo.mr_findFirst()?.avatar {
            userProfileImagv.sd_setImage(with: URL.init(string: PYADDRESS_URL + profile))
        }
        if let username = UserInfo.mr_findFirst()?.username {
            userNickLab.text = "Hi,"+username
        }
        if let dep = UserInfo.mr_findFirst()?.dep {
            userGroupingLab.text = dep
        }
    }
    
    @objc func clickToSelect(sender:UIButton) {
        switch sender.tag {
        case 0:
            let vc = AddressBookController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = MessageCenterViewController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = EmployeeStatisticsViewController.init()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = SalaryStatisticsViewController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
        
    }
    

}
