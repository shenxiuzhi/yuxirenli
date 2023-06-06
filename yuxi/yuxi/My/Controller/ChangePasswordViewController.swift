//
//  ChangePasswordViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/11.
//

import UIKit
import SwiftyJSON

class ChangePasswordViewController: YUXIBaseController, UITextFieldDelegate {
    
    var bgView = UIView()
    
    var jobIDLab = UILabel()
    var jobIDTF = UILabel.init()
    var jobIDUnderline = UIView()
    
    var oldPasswordLab = UILabel()
    var oldPasswordTF = UITextField.init()
    var oldPasswordUnderline = UIView()
    
    var newPasswordLab = UILabel()
    var newPasswordTF = UITextField.init()
    var newPasswordUnderline = UIView()
    
    var confirmNewPasswordLab = UILabel()
    var confirmNewPasswordTF = UITextField.init()
    var confirmNewPasswordUnderline = UIView()
    
    var tipImage1 = UIImageView.init(image: UIImage.init(named: "Red_Tip_Prompt"))
    var tipLab1 = UILabel()
    var submitToBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.YUXICreateNavbar(navTitle: "修改密码", leftImage: "L_back", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.view.backgroundColor = YUXICOLOR(h: 0xF3F3F3, alpha: 1)
        
        
        setUpUI()
        
    }
    
    func setUpUI() {
        bgView.backgroundColor = .white
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview().offset(YUXINEWNAVHEIGHT)
        } 
        
        jobIDLab.text = "我的工号"
        jobIDLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        jobIDLab.textAlignment = .left
        jobIDLab.font = UIFont.fontWith(size: 20)
        bgView.addSubview(jobIDLab)
        jobIDLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(30))
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.height.equalTo(WIDTH_SCALE(28))
        }
//        jobIDTF.placeholder = "请输入工号"
        jobIDTF.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
//        jobIDTF.delegate = self
        if let number = UserInfo.mr_findFirst()?.number {
            jobIDTF.text = number
        }
//        jobIDTF.isEditing = false
        jobIDTF.font = UIFont.systemFont(ofSize: WIDTH_SCALE(16))
//        jobIDTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
//        jobIDTF.clearButtonMode = .always
        jobIDTF.backgroundColor = UIColor.white
        bgView.addSubview(jobIDTF)
        jobIDTF.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.centerY.equalTo(jobIDLab)
            make.width.equalTo(WIDTH_SCALE(203))
            make.height.equalTo(WIDTH_SCALE(20))
        }
        jobIDUnderline.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        bgView.addSubview(jobIDUnderline)
        jobIDUnderline.snp.makeConstraints { make in
            make.centerX.equalTo(jobIDTF)
            make.width.equalTo(WIDTH_SCALE(205))
            make.top.equalTo(jobIDTF.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        //-------
        oldPasswordLab.text = "旧密码"
        oldPasswordLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        oldPasswordLab.textAlignment = .left
        oldPasswordLab.font = UIFont.fontWith(size: 20)
        bgView.addSubview(oldPasswordLab)
        oldPasswordLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(jobIDLab.snp.bottom).offset(WIDTH_SCALE(30))
            make.height.equalTo(WIDTH_SCALE(28))
        }
        oldPasswordTF.placeholder = "请输入旧密码"
        oldPasswordTF.isSecureTextEntry = true
        oldPasswordTF.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        oldPasswordTF.delegate = self
        oldPasswordTF.font = UIFont.systemFont(ofSize: WIDTH_SCALE(16))
        oldPasswordTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        oldPasswordTF.clearButtonMode = .always
        oldPasswordTF.backgroundColor = UIColor.white
        bgView.addSubview(oldPasswordTF)
        oldPasswordTF.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.centerY.equalTo(oldPasswordLab)
            make.width.equalTo(WIDTH_SCALE(203))
            make.height.equalTo(WIDTH_SCALE(20))
        }
        oldPasswordUnderline.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        bgView.addSubview(oldPasswordUnderline)
        oldPasswordUnderline.snp.makeConstraints { make in
            make.centerX.equalTo(oldPasswordTF)
            make.width.equalTo(WIDTH_SCALE(205))
            make.top.equalTo(oldPasswordLab.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        
        //----
        newPasswordLab.text = "新密码"
        newPasswordLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        newPasswordLab.textAlignment = .left
        newPasswordLab.font = UIFont.fontWith(size: 20)
        bgView.addSubview(newPasswordLab)
        newPasswordLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(oldPasswordLab.snp.bottom).offset(WIDTH_SCALE(30))
            make.height.equalTo(WIDTH_SCALE(28))
        }
        newPasswordTF.placeholder = "请输入新密码"
        newPasswordTF.isSecureTextEntry = true
        newPasswordTF.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        newPasswordTF.delegate = self
        newPasswordTF.font = UIFont.systemFont(ofSize: WIDTH_SCALE(16))
        newPasswordTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        newPasswordTF.clearButtonMode = .always
        newPasswordTF.backgroundColor = UIColor.white
        bgView.addSubview(newPasswordTF)
        newPasswordTF.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.centerY.equalTo(newPasswordLab)
            make.width.equalTo(WIDTH_SCALE(203))
            make.height.equalTo(WIDTH_SCALE(20))
        }
        newPasswordUnderline.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        bgView.addSubview(newPasswordUnderline)
        newPasswordUnderline.snp.makeConstraints { make in
            make.centerX.equalTo(newPasswordTF)
            make.width.equalTo(WIDTH_SCALE(205))
            make.top.equalTo(newPasswordTF.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        
        //----
        confirmNewPasswordLab.text = "确定新密码"
        confirmNewPasswordLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        confirmNewPasswordLab.textAlignment = .left
        confirmNewPasswordLab.font = UIFont.fontWith(size: 20)
        bgView.addSubview(confirmNewPasswordLab)
        confirmNewPasswordLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.top.equalTo(newPasswordTF.snp.bottom).offset(WIDTH_SCALE(30))
            make.height.equalTo(WIDTH_SCALE(28))
        }
        confirmNewPasswordTF.placeholder = "请输入新密码"
        confirmNewPasswordTF.isSecureTextEntry = true
        confirmNewPasswordTF.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        confirmNewPasswordTF.delegate = self
        confirmNewPasswordTF.font = UIFont.systemFont(ofSize: WIDTH_SCALE(16))
        confirmNewPasswordTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        confirmNewPasswordTF.clearButtonMode = .always
        confirmNewPasswordTF.backgroundColor = UIColor.white
        bgView.addSubview(confirmNewPasswordTF)
        confirmNewPasswordTF.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(WIDTH_SCALE(-18))
            make.centerY.equalTo(confirmNewPasswordLab)
            make.width.equalTo(WIDTH_SCALE(203))
            make.height.equalTo(WIDTH_SCALE(20))
        }
        confirmNewPasswordUnderline.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        bgView.addSubview(confirmNewPasswordUnderline)
        confirmNewPasswordUnderline.snp.makeConstraints { make in
            make.centerX.equalTo(confirmNewPasswordTF)
            make.width.equalTo(WIDTH_SCALE(205))
            make.top.equalTo(confirmNewPasswordTF.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        
        tipImage1.isHidden = true
        tipLab1.isHidden = true
        bgView.addSubview(tipImage1)
        tipImage1.snp.makeConstraints { make in
            make.top.equalTo(confirmNewPasswordLab.snp.bottom).offset(WIDTH_SCALE(25))
            make.left.equalToSuperview().offset(WIDTH_SCALE(18))
            make.width.height.equalTo(WIDTH_SCALE(12))
        }
        tipLab1.text = "请输入空白框"
        tipLab1.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        tipLab1.font = UIFont.fontWith(size: 10)
        bgView.addSubview(tipLab1)
        tipLab1.snp.makeConstraints { make in
            make.centerY.equalTo(tipImage1)
            make.left.equalTo(tipImage1.snp.right).offset(WIDTH_SCALE(2))
        }
        
        submitToBtn.setBackgroundImage(UIImage.init(named: "Login_Button_bg"), for: .normal)
        submitToBtn.setTitle("提交", for: .normal)
        submitToBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        submitToBtn.titleLabel?.font = UIFont.fontWith(size: 16)
        submitToBtn.addTarget(self, action: #selector(submitToAction), for: .touchUpInside)
        bgView.addSubview(submitToBtn)
        submitToBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipImage1.snp.bottom).offset(WIDTH_SCALE(51))
            make.width.equalTo(WIDTH_SCALE(142))
            make.height.equalTo(WIDTH_SCALE(32))
        }
        
        
    }
    
    
    ///修改密码接口
    @objc func submitToAction() {
//        if jobIDTF.text == "" {
//            tipImage1.isHidden = false
//            tipLab1.isHidden = false
//            tipLab1.text = "请输入空白框"
//            return
//        }
        if oldPasswordTF.text == "" {
            tipImage1.isHidden = false
            tipLab1.isHidden = false
            tipLab1.text = "请输入空白框"
            return
        }
        if newPasswordTF.text == "" {
            tipImage1.isHidden = false
            tipLab1.isHidden = false
            tipLab1.text = "请输入空白框"
            return
        }
        if confirmNewPasswordTF.text == "" {
            tipImage1.isHidden = false
            tipLab1.isHidden = false
            tipLab1.text = "请输入空白框"
            return
        }
//        if oldPasswordTF.text != UserInfo.mr_findFirst()?.access_token {
//            tipImage1.isHidden = false
//            tipLab1.isHidden = false
//            tipLab1.text = "请输正确的旧密码"
//            return
//        }
        if let text = newPasswordTF.text{
            if text.count < 6 {
                tipImage1.isHidden = false
                tipLab1.isHidden = false
                tipLab1.text = "密码长度低于6位数，请重新设置"
                return
            }
        }
        if oldPasswordTF.text == newPasswordTF.text {
            tipImage1.isHidden = false
            tipLab1.isHidden = false
            tipLab1.text = "新密码与旧密码一样"
            return
        }
        if confirmNewPasswordTF.text != newPasswordTF.text {
            tipImage1.isHidden = false
            tipLab1.isHidden = false
            tipLab1.text = "两次新密码不一致"
            return
        }
        //
        
        self.view.makeToastActivity(.center)
        let parms = ["code":jobIDTF.text!,"pwd":oldPasswordTF.text!,"newPwd":newPasswordTF.text!] as [String : Any]
        let checkParms = [jobIDTF.text!,oldPasswordTF.text!,newPasswordTF.text!]
        SURLRequest.sharedInstance.requestPostWithHeader(Login_Passwordn, param: parms, checkSum: checkParms) { [weak self] (data) in
            if let weakself = self {
                let json = JSON(data)
                Dprint("Login_Passwordn:\(json)")
                
                let content = json["content"]
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                if code == 200 {
                    let view = SuccessfullyModifiedPasswordPopView()
                    view.show()
                    view.closePopUpBlock = {
                        UIViewController.getCurrentViewCtrl().navigationController?.popViewController(animated:true)
                        SRequestObject.shared.exitLoginInterface()
                    }
                }else{
                    UIViewController.getCurrentViewCtrl().view.makeToast(msg,position: .center)
                }
                weakself.view.hideToastActivity()
            }
        } err: {[weak self] error in
            Dprint("Login_Passwordn====== \(error)")
            self?.view.hideToastActivity()
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        tipImage1.isHidden = true
        tipLab1.isHidden = true
    }
//    // 该方法代表输入框已经可以开始编辑  进入编辑状态
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("我正在编辑状态中...")
//    }
    //MARK: -通知
//    func noticeMessage(){
//        let center = NotificationCenter.default
//        center.addObserver(self, selector: #selector(showKeyboar(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
//
//
//    }
//    func removeNotice(){
//        let center = NotificationCenter.default
//        center.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
//
//    }
//
//    deinit {
//        self.removeNotice()
//    }
//
//    var isKeyboar = false
//
//    //MARK: 键盘相关
//    @objc func showKeyboar(notification: NSNotification){
//        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{
//            return
//        }
//
//        //获取键盘最终Y值
//        let endPointY = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.origin.y
//        let textfY = textFBgView.frame.origin.y + 90
//
//
//        if textfY > endPointY {
//            let differ = textfY - endPointY
//            UIView.animate(withDuration: duration) {
//                self.bgView.frame = CGRect(x:0, y:-differ-10, width:YUXISCREEN_WIDTH, height:YUXISCREEN_HEIGHT)
//            }
//            isKeyboar = true
//        }else {
//            UIView.animate(withDuration: duration) {
//                self.bgView.frame = CGRect(x:0, y:0, width:YUXISCREEN_WIDTH, height:YUXISCREEN_HEIGHT)
//            }
//            isKeyboar = false
//        }
//
//
//    } //键盘展示
    
    // 点击view空白收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
//        if isKeyboar == false {
//            return
//        }
//        UIView.animate(withDuration: 0.25) {
//            self.bgView.frame = CGRect(x:0, y:0, width:YUXISCREEN_WIDTH, height:YUXISCREEN_HEIGHT)
//        }
//        isKeyboar = false
    }

}
