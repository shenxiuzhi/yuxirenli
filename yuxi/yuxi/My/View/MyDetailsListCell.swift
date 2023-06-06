//
//  MyDetailsListCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit

class MyDetailsListCell: UITableViewCell {
    
    var bgView = UIView()
    
    var imagv = UIImageView()
    
    var label = UILabel()
    
    let bgWidth = YUXISCREEN_HEIGHT - CGFloat(WIDTH_SCALE(36))
    
    var index = 0 {
        didSet {
            if index == 0 {
                bgView.corner(byRoundingCorners: [.topLeft, .topRight], radii: CGFloat(WIDTH_SCALE(10)), rect: CGRect.init(x: 0, y: 0, width:bgWidth, height: CGFloat(WIDTH_SCALE(50))))
            }else if index == 1 {
                
            }else {
                bgView.corner(byRoundingCorners: [.bottomLeft, .bottomRight], radii: CGFloat(WIDTH_SCALE(10)), rect: CGRect.init(x: 0, y: 0, width:bgWidth, height: CGFloat(WIDTH_SCALE(50))))
            }
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
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.top.bottom.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(50))
        }
        
        bgView.addSubview(imagv)
        imagv.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(WIDTH_SCALE(24))
            make.left.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        
        label.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont.fontWith(size: 16)
        bgView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(imagv.snp.right).offset(WIDTH_SCALE(11))
            make.centerY.equalToSuperview()
        }
        
    }

}
