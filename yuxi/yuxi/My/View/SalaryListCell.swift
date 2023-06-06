//
//  SalaryListCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit

class SalaryListCell: UITableViewCell {
    
    var bgView = UIView()
    var moonBgimagv = UIImageView()
    var moonLab = UILabel()
    var titleLab = UILabel()
    var incomeLab = UILabel()
    var timeLab = UILabel()
    
    var index:Int = 0
    var model = MySalaryDetailsYaerListModel(){
        didSet {
            moonLab.text = model.month
            titleLab.text = "工资薪金"
            incomeLab.text = "收入: \(model.s_count)"
            timeLab.text = "入账时间：\(model.update_time)"
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
        bgView.layer.borderColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1).cgColor
        bgView.layer.borderWidth = 1
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(71))
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.height.equalTo(WIDTH_SCALE(54))
            make.top.equalToSuperview().offset(WIDTH_SCALE(6))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-5))
        }
        
        moonBgimagv.image = UIImage(named: "Salary_Details_Moon_bg")
        self.contentView.addSubview(moonBgimagv)
        moonBgimagv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(5))
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.width.equalTo(WIDTH_SCALE(66))
            make.height.equalTo(WIDTH_SCALE(53))
        }
//        moonLab.text = "01"
        moonLab.textColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        moonLab.textAlignment = .center
        moonLab.font = UIFont.fontWith(.Semibold, size: 24)
        moonBgimagv.addSubview(moonLab)
        moonLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(WIDTH_SCALE(4))
        }
        
//        titleLab.text = "工资薪金"
        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(size: 16)
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(21))
            make.top.equalToSuperview().offset(WIDTH_SCALE(5))
        }
        
//        incomeLab.text = "收入: 8888888"
        incomeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        incomeLab.font = UIFont.fontWith(size: 12)
        bgView.addSubview(incomeLab)
        incomeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(21))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-5))
        }
        
//        timeLab.text = "入账时间：2023-03"
        timeLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        timeLab.font = UIFont.fontWith(size: 12)
        bgView.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-5))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-5))
        }
        
    }

}
