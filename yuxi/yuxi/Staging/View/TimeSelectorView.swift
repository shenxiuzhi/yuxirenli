//
//  TimeSelectorView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/16.
//

import UIKit

typealias familyDatePickerblock = (_ date : Date) -> Void

class TimeSelectorView: UIView {
    var sendDate: familyDatePickerblock?
    var closeView: (()->())?
    let datePic: UIDatePicker = UIDatePicker.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(cancleBtnAction))
        self.addGestureRecognizer(tap)
        
        self.setUI()
        
    }
    func setUI(){
        let view = UIView.init(frame: CGRect.init(x: 0, y: YUXISCREEN_HEIGHT - WIDTH_SCALE(290), width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(290)))
        view.backgroundColor = .white
        self.addSubview(view)
        
        datePic.frame = CGRect.init(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(150))
        datePic.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePic.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePic.locale = Locale(identifier: "zh_CN")
        datePic.maximumDate = Date()
        
        // 设置默认时间
        datePic.date = Date()
        view.addSubview(datePic)
        
        
        let cancleBtn = UIButton.init(type: .custom)
        cancleBtn.setBackgroundImage(UIImage.init(named: "Time_Cancle_bg"), for: .normal)
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.setTitleColor(YUXICOLOR(h: 0x333333, alpha: 1), for: .normal)
        cancleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancleBtn.addTarget(self, action: #selector(cancleBtnAction), for: .touchUpInside)
        view.addSubview(cancleBtn)
        cancleBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(53))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(92))
            make.height.equalTo(WIDTH_SCALE(32))
        }
        
        let confirmBtn = UIButton.init(type: .custom)
        confirmBtn.setBackgroundImage(UIImage.init(named: "Time_Confirm_bg"), for: .normal)
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.setTitleColor(YUXICOLOR(h: 0x333333, alpha: 1), for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-53))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
            make.width.equalTo(WIDTH_SCALE(92))
            make.height.equalTo(WIDTH_SCALE(32))
        }
    }
    
    //MARK: - Action
    @objc func confirmAction(){
        self.sendDate!(datePic.date)
        self.removeFromSuperview()
    }//确认
    @objc func cancleBtnAction(){
        self.removeFromSuperview()
        if let block = self.closeView {
            block()
        }
    }//取消

}
