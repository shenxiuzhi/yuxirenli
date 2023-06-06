//
//  MyHeaderView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit
import SDWebImage
import MagicalRecord
class MyHeaderView: UIView {
    
    
    
    var userProfileImagv = UIImageView()
    var userNickLab = UILabel()
    var userGroupingLab = UILabel()
    var userJobLab = UILabel()
    var userPhoneLab = UILabel()
    
    var model = UserInfo.mr_findFirst() {
        didSet{
            if let profile = model?.avatar {
                userProfileImagv.sd_setImage(with: URL.init(string: PYADDRESS_URL + profile))
            }
            if let username = model?.username {
                userNickLab.text = "Hi,"+username
            }
            if let number = model?.number {
                userJobLab.text = "工号:\(number)"
            }
            if let mobile = model?.mobile {
                userPhoneLab.text = "手机号:\(mobile)"
            }
            if let dep = model?.dep {
                userGroupingLab.text = dep
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        userProfileImagv.image = UIImage(named: "Default_Occupation_Bitmap")
        userProfileImagv.layer.cornerRadius = CGFloat(32*YUXIIPONE_SCALE)
        userProfileImagv.layer.masksToBounds = true
        self.addSubview(userProfileImagv)
        userProfileImagv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
            make.width.height.equalTo(WIDTH_SCALE(64))
        }
        
        userNickLab.text = "Hi,申修智"
        userNickLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        userNickLab.font = UIFont.fontWith(.Semibold, size: WIDTH_SCALE(16))
        userNickLab.textAlignment = .left
        self.addSubview(userNickLab)
        userNickLab.snp.makeConstraints { make in
            make.left.equalTo(userProfileImagv.snp.right).offset(WIDTH_SCALE(10))
            make.top.equalTo(userProfileImagv.snp.top)
            make.width.lessThanOrEqualTo(WIDTH_SCALE(200))
        }
        
        
        userGroupingLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        userGroupingLab.font = UIFont.fontWith(size: WIDTH_SCALE(12))
        userGroupingLab.textAlignment = .left
        self.addSubview(userGroupingLab)
        userGroupingLab.snp.makeConstraints { make in
            make.left.equalTo(userNickLab)
            make.top.equalTo(userProfileImagv.snp.top).offset(WIDTH_SCALE(27))
        }
        
        userJobLab.text = "工号:88888888"
        userJobLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        userJobLab.font = UIFont.fontWith(size: WIDTH_SCALE(11))
        userJobLab.textAlignment = .left
        self.addSubview(userJobLab)
        userJobLab.snp.makeConstraints { make in
            make.left.equalTo(userGroupingLab.snp.right).offset(WIDTH_SCALE(10))
            make.centerY.equalTo(userGroupingLab)
        }
        
        userPhoneLab.text = "手机号:13245786031"
        userPhoneLab.textColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        userPhoneLab.font = UIFont.fontWith(size: WIDTH_SCALE(11))
        userPhoneLab.textAlignment = .left
        self.addSubview(userPhoneLab)
        userPhoneLab.snp.makeConstraints { make in
            make.bottom.equalTo(userProfileImagv)
            make.left.equalTo(userNickLab)
        }
        
    }

}
