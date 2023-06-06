//
//  YUXILoginAccountController.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/28.
//

import UIKit
import SwiftyJSON
import Toast_Swift

class YUXILoginAccountController: YUXIBaseController, UITextFieldDelegate {
    
    var bgView = UIView()
    
    var textFBgView = UIView()
    
    var jobIDLab = UILabel()
    var jobIDTF = UITextField.init()
    var jobIDUnderline = UIView()
    
    var passwordLab = UILabel()
    var passwordTF = UITextField.init()
    var passwordUnderline = UIView()
    
    var loginBtn = UIButton()
    var forgotPassword = UIButton()
    var bottomCompanyLab = UILabel()
    
    var jobIdNum = ""
    var passwordNum = ""
    
    var telStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bgView.backgroundColor = .white
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.YUXICreateNavbarLeft(navTitle: "登录", navTitleColorIsWidth: false)
//        self.YUXICreateNavbar(navTitle: "登录", leftImage: "", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.isNavBarClear = true
//        self.isHiddenBackBtn = true
        self.YUXInavTitleL.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        let lineV = UIView()
        lineV.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.navBarV.addSubview(lineV)
        lineV.snp.makeConstraints { make in
            make.top.equalTo(self.YUXInavTitleL.snp.bottom).offset(WIDTH_SCALE(-12))
            make.left.equalToSuperview().offset(WIDTH_SCALE(15))
            make.width.equalTo(WIDTH_SCALE(44))
            make.height.equalTo(WIDTH_SCALE(2))
        }
        
        setBgUI()
        setupUI()
        
        noticeMessage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLoginTel()
    }
    
    override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidAppear(_ animated:Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setBgUI() {
        let topBgImage = UIImageView()
        topBgImage.image = UIImage(named: "Login_top_bg")
        bgView.addSubview(topBgImage)
        topBgImage.snp.makeConstraints { make in
            make.right.top.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(328))
            make.height.equalTo(WIDTH_SCALE(293))
        }
        
        let identifyingImage = UIImageView()
        identifyingImage.image = UIImage(named: "Login_identifying")
        bgView.addSubview(identifyingImage)
        identifyingImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(WIDTH_SCALE(88)+YUXINEWNAVHEIGHT)
            make.width.equalTo(WIDTH_SCALE(233))
            make.height.equalTo(WIDTH_SCALE(75))
        }
        
        let bottomBgImage = UIImageView()
        bottomBgImage.image = UIImage(named: "Login_bottom_bg")
        bgView.addSubview(bottomBgImage)
        bottomBgImage.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(WIDTH_SCALE(173))
            make.height.equalTo(WIDTH_SCALE(195))
        }
        
        
    }
    
    
    func setupUI() {
        
        textFBgView.backgroundColor = .clear
        bgView.addSubview(textFBgView)
        textFBgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(WIDTH_SCALE(240)+YUXINEWNAVHEIGHT)
            make.height.equalTo(WIDTH_SCALE(90))
        }
        
        jobIDLab.text = "工号"
        jobIDLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        jobIDLab.textAlignment = .left
        jobIDLab.font = UIFont.fontWith(size: 20)
        textFBgView.addSubview(jobIDLab)
        jobIDLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(WIDTH_SCALE(2))
            make.left.equalToSuperview().offset(WIDTH_SCALE(62))
            make.height.equalTo(WIDTH_SCALE(28))
        }
        jobIDTF.placeholder = "请输入工号"
        jobIDTF.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        jobIDTF.delegate = self
//        jobIDTF.keyboardType = .numberPad
        jobIDTF.font = UIFont.systemFont(ofSize: WIDTH_SCALE(16))
        jobIDTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        jobIDTF.clearButtonMode = .always
        jobIDTF.backgroundColor = UIColor.white
        textFBgView.addSubview(jobIDTF)
        jobIDTF.snp.makeConstraints { make in
            make.left.equalTo(jobIDLab.snp.right).offset(WIDTH_SCALE(8))
            make.centerY.equalTo(jobIDLab)
            make.width.equalTo(WIDTH_SCALE(203))
            make.height.equalTo(WIDTH_SCALE(20))
        }
        jobIDUnderline.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        textFBgView.addSubview(jobIDUnderline)
        jobIDUnderline.snp.makeConstraints { make in
            make.centerX.equalTo(jobIDTF)
            make.width.equalTo(WIDTH_SCALE(205))
            make.top.equalTo(jobIDTF.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        
        passwordLab.text = "密码"
        passwordLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        passwordLab.textAlignment = .left
        passwordLab.font = UIFont.fontWith(size: 20)
        textFBgView.addSubview(passwordLab)
        passwordLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(62))
            make.top.equalTo(jobIDLab.snp.bottom).offset(WIDTH_SCALE(30))
            make.height.equalTo(WIDTH_SCALE(28))
        }
        passwordTF.placeholder = "请输入密码"
        passwordTF.isSecureTextEntry = true
        passwordTF.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        passwordTF.delegate = self
        passwordTF.font = UIFont.systemFont(ofSize: WIDTH_SCALE(16))
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        passwordTF.clearButtonMode = .always
        passwordTF.backgroundColor = UIColor.white
        textFBgView.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { make in
            make.left.equalTo(passwordLab.snp.right).offset(WIDTH_SCALE(8))
            make.centerY.equalTo(passwordLab)
            make.width.equalTo(WIDTH_SCALE(203))
            make.height.equalTo(WIDTH_SCALE(20))
        }
        passwordUnderline.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        textFBgView.addSubview(passwordUnderline)
        passwordUnderline.snp.makeConstraints { make in
            make.centerX.equalTo(passwordTF)
            make.width.equalTo(WIDTH_SCALE(205))
            make.top.equalTo(passwordTF.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        
        
        
        
        loginBtn.setBackgroundImage(UIImage.init(named: "Login_Button_bg"), for: .normal)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(YUXICOLOR(h: 0xFFFFFF, alpha: 1), for: .normal)
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        bgView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(WIDTH_SCALE(434)+YUXINEWNAVHEIGHT)
            make.width.equalTo(WIDTH_SCALE(324))
            make.height.equalTo(WIDTH_SCALE(42))
        }
        
        forgotPassword.setTitle("忘记密码", for: .normal)
        forgotPassword.setTitleColor(YUXICOLOR(h: 0x1158F0, alpha: 1), for: .normal)
        forgotPassword.titleLabel?.font = UIFont.fontWith(size: 12)
        forgotPassword.addTarget(self, action: #selector(forgotPasswordAction(sender:)), for: .touchUpInside)
        forgotPassword.underline()
        bgView.addSubview(forgotPassword)
        forgotPassword.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtn.snp.bottom).offset(WIDTH_SCALE(7))
        }
        
        bottomCompanyLab.text = "山西兰花科创玉溪煤矿有限责任公司"
        bottomCompanyLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        bottomCompanyLab.font = UIFont.fontWith(size: 12)
        bottomCompanyLab.textAlignment = .center
        bgView.addSubview(bottomCompanyLab)
        bottomCompanyLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-12)-YUXIIPHONEX_BH)
        }
        
        
        
        
    }
    
    // MARK:- textfield输入监听
    @objc func textFieldDidChange(textField: UITextField){
        if textField == jobIDTF{
            if textField.markedTextRange == nil{//过滤y拼音
                if let string = textField.text{
                    jobIdNum = string
                }
            }
        }
        if textField == passwordTF{
            if textField.markedTextRange == nil{//过滤y拼音
                if let string = textField.text{
                    passwordNum = string
                }
            }
        }
  
    }
    
    
    //登录点击事件
    @objc func loginAction() {
        loginRequest()
    }
    
    //忘记密码点击事件
    @objc func forgotPasswordAction(sender: UIButton) {
        let view = ForgotPasswordView()
        view.tel = telStr
        view.show()
    }
    
    //MARK: -通知
    func noticeMessage(){
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(showKeyboar(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        
    }
    func removeNotice(){
        let center = NotificationCenter.default
        center.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        
    }
    
    deinit {
        self.removeNotice()
    }
    
    var isKeyboar = false
    
    //MARK: 键盘相关
    @objc func showKeyboar(notification: NSNotification){
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{
            return
        }
        
        //获取键盘最终Y值
        let endPointY = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.origin.y
        let textfY = textFBgView.frame.origin.y + 90
        
        
        if textfY > endPointY {
            let differ = textfY - endPointY
            UIView.animate(withDuration: duration) {
                self.bgView.frame = CGRect(x:0, y:-differ-10, width:YUXISCREEN_WIDTH, height:YUXISCREEN_HEIGHT)
            }
            isKeyboar = true
        }else {
            UIView.animate(withDuration: duration) {
                self.bgView.frame = CGRect(x:0, y:0, width:YUXISCREEN_WIDTH, height:YUXISCREEN_HEIGHT)
            }
            isKeyboar = false
        }
            
        
    } //键盘展示
    
    // 点击view空白收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if isKeyboar == false {
            return
        }
        UIView.animate(withDuration: 0.25) {
            self.bgView.frame = CGRect(x:0, y:0, width:YUXISCREEN_WIDTH, height:YUXISCREEN_HEIGHT)
        }
        isKeyboar = false
    }
    
    //MARK: 接口请求
    //登录接口
    func loginRequest() {
        if jobIdNum == "" {
            UIViewController.getCurrentViewCtrl().view.makeToast("请输入工号",position: .center)
            return
        }
        if passwordNum == "" {
            UIViewController.getCurrentViewCtrl().view.makeToast("请输入密码",position: .center)
            return
        }
        
        self.view.makeToastActivity(.center)
        let parms = ["userName":jobIdNum,"password":passwordNum,"clientInfo":getUUID()] as [String : Any]
        let checkParms = [jobIdNum,passwordNum,getUUID()]
        SURLRequest.sharedInstance.requestPostWithHeader(Login_login, param: parms, checkSum: checkParms) { [weak self] (data) in
            if let weakself = self {
                let json = JSON(data)
                Dprint("Login_login:\(json)")
                
                let content = json["data"]
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                let number = content["number"].stringValue
                if code == 200 {
                    UserInfoModel.userData(content: content)
//                    weakself.getURLUserInfoRequset(code: number)
                    let tabbarVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    UIApplication.shared.keyWindow?.rootViewController = tabbarVC
                    UIViewController.getCurrentViewCtrl().view.makeToast(msg,position: .center)
                }else{
                    SURLHelper.judgeExpiredLoginAndMakeToast(data: data)
                    weakself.view.hideToastActivity()
                    UIViewController.getCurrentViewCtrl().view.makeToast(msg,position: .center)
                }
                
            }
        } err: {[weak self] error in
            Dprint("Login_loginerror====== \(error)")
            self?.view.hideToastActivity()
        }
    }
    
    //客服电话
    func setLoginTel() {
        SURLRequest.sharedInstance.requestPostWithHeader(URL_Login_Tel, param: nil, checkSum: []) { [weak self] (data) in
            if let weakself = self {
                let json = JSON(data)
                Dprint("URL_Login_Tel:\(json)")
                let tel = json["data"].stringValue
                let code = json["code"].intValue
                if code == 200 {
                    weakself.telStr = tel
                }
            }
        } err: {[weak self] error in
            Dprint("URL_Login_Tel====== \(error)")
        }
    }
    
    
}
