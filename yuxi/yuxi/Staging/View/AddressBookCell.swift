//
//  AddressBookCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/5.
//

import UIKit

class AddressBookCell: UITableViewCell {
    
    var image = UIImageView()
    var label = UILabel()
    
    var model:AddressBookModel! {
        didSet {
            label.text = model.name
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
        image.image = UIImage(named: "arrow_blue_r")
        self.contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(23))
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.width.height.equalTo(WIDTH_SCALE(16))
        }
        
        
        label.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        label.font = UIFont.fontWith(size: 16)
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(39))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        
    }

}
