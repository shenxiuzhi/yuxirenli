//
//  SetUpCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/11.
//

import UIKit

class SetUpCell: UITableViewCell {
    
    var bgView = UIView()
    
    var titleLab = UILabel()
    
    var rImagv = UIImageView()
    
    var modelStr = "" {
        didSet {
            titleLab.text = modelStr
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

    func setupUI(){
        
        bgView.backgroundColor = .white
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(54))
            make.top.equalToSuperview().offset(WIDTH_SCALE(10))
        }
        
        titleLab.text = "修改密码"
        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(.Medium, size: 16)
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(WIDTH_SCALE(21))
        }
        
        rImagv.image = UIImage.init(named: "R_back")
        bgView.addSubview(rImagv)
        rImagv.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-21))
            make.width.equalTo(WIDTH_SCALE(10))
            make.height.equalTo(WIDTH_SCALE(16))
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    
}
