//
//  MessageDetailsViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/12.
//

import UIKit

class MessageDetailsViewController: YUXIBaseController {
    
    var titleLab = UILabel()
    var timeLab = UILabel()
    var contentLab = UILabel()
    
    var model = MessageCenterListModel() {
        didSet {
            titleLab.text = model.title
            contentLab.text = model.model
            timeLab.text = model.update_time
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.YUXICreateNavbar(navTitle: "消息简介", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.isNavBarClear = true
        self.navBarV.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.view.backgroundColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        
        setUpUI()
    }
    func setUpUI() {

        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(.Semibold, size: 18)
        self.view.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(YUXINEWNAVHEIGHT+WIDTH_SCALE(20))
            make.centerX.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(24))
            make.width.lessThanOrEqualTo(WIDTH_SCALE(255))
        }

        timeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        timeLab.font = UIFont.fontWith(size: 9)
        self.view.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(WIDTH_SCALE(30))
            make.height.equalTo(WIDTH_SCALE(13))
        }
        
//        contentLab.text = "    早晨，从山坡上，从坪坝里，从一条条开着绒球花和太阳花的小路上，走来了许多小学生，有傣族的，有景颇族的，有阿昌族和德昂族的，还有汉族的。大家穿戴不同、语言不同，来到学校，都成了好朋友。那鲜艳的民族服装，把学校打扮得更加绚丽多彩。同学们向在校园里欢唱的小鸟打招呼，向敬爱的老师问好，向高高飘扬的国旗敬礼。\n    “当，当当！当，当当！”大青树上钟声敲响了。"
        contentLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        contentLab.font = UIFont.fontWith(size: 16)
        contentLab.numberOfLines = 0
        self.view.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.top.equalTo(timeLab.snp.bottom).offset(WIDTH_SCALE(20))
        }
    }

}
