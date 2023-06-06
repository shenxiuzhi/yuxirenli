//
//  MessageCenterListCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/12.
//

import UIKit

class MessageCenterListCell: UITableViewCell {
    
    var bgView = UIView()
    var imagev = UIImageView()
    var titleLab = UILabel()
    var contentLab = UILabel()
    var timeLab = UILabel()
    var redLab = UILabel()
    var lineView = UIView()
    
    var model = MessageCenterListModel(){
        didSet{
            titleLab.text = model.title
//            contentLab.text = model.model
            timeLab.text = model.date
            if model.status == 0 {
                redLab.isHidden = false
            }else {
                redLab.isHidden = true
            }
        }
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupInterface()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface() {
        bgView.backgroundColor = .clear
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        imagev.image = UIImage.init(named: "Staging_Grouping")
        self.bgView.addSubview(imagev)
        imagev.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.centerY.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(32))
            make.height.equalTo(WIDTH_SCALE(31))
        }
        titleLab.text = "消息简称"
        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(size: 16)
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(imagev.snp.right).offset(WIDTH_SCALE(10))
            make.top.equalToSuperview().offset(WIDTH_SCALE(10))
            make.width.lessThanOrEqualTo(WIDTH_SCALE(241))
        }
        contentLab.text = "消息内容消息内容消息内容消息内容"
        contentLab.isHidden = true
        contentLab.textColor = YUXICOLOR(h: 0x666666, alpha: 1)
        contentLab.font = UIFont.fontWith(size: 10)
        bgView.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-11))
            make.width.lessThanOrEqualTo(WIDTH_SCALE(241))
        }
        timeLab.text = "20:08"
        timeLab.textColor = YUXICOLOR(h: 0x666666, alpha: 1)
        timeLab.font = UIFont.fontWith(size: 9)
        bgView.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.top.equalToSuperview().offset(WIDTH_SCALE(10))
        }
        redLab.layer.cornerRadius = WIDTH_SCALE(3)
        redLab.layer.masksToBounds = true
        redLab.textColor = .white
        redLab.backgroundColor = .red
        redLab.textAlignment = .center
        redLab.font = UIFont.fontWith(size: 8)
        bgView.addSubview(redLab)
        redLab.snp.makeConstraints { make in
            make.right.top.equalTo(imagev)
            make.width.height.equalTo(WIDTH_SCALE(6))
        }
        lineView.backgroundColor = YUXICOLOR(h: 0xE4E4E4, alpha: 1)
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(60))
            make.right.equalToSuperview().offset(WIDTH_SCALE(-13))
            make.height.equalTo(WIDTH_SCALE(1))
            make.bottom.equalToSuperview()
        }
        
    }
}

