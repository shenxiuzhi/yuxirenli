//
//  MyViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/28.
//

import UIKit
import SwiftyJSON

class MyViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
    var headView = MyHeaderView.init(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(101)))
    
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(MyDetailsListCell.self, forCellReuseIdentifier: "MyDetailsListCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    
    let bgImagv = UIImageView()
    
    var dataArr = [["image": "My_Salary","title":"我的薪资"],["image": "My_Attendance","title":"我的考勤"],["image": "My_Set_Up","title":"设置"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bgImagv.image = UIImage(named: "Staging_Bg")
        bgImagv.isUserInteractionEnabled = true
        self.view.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.YUXICreateNavbarLeft(navTitle: "玉溪人力资源", navTitleColorIsWidth: false)
//        self.YUXICreateNavbar(navTitle: "山西兰花科技", leftImage: "", rightStr: "", ringhtAction: nil,rightIsImage: false,titleIsRight:false)
//        self.isHiddenBackBtn = true
        // Do any additional setup after loading the view.
        
        tableView.tableHeaderView = headView
        bgImagv.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(headViewAction))
        headView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let model = UserInfo.mr_findFirst() {
            headView.model = model
        }
        getURLUserInfoRequset()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDetailsListCell", for: indexPath) as! MyDetailsListCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        if indexPath.row < dataArr.count {
            let image = dataArr[indexPath.row]["image"]
            let title = dataArr[indexPath.row]["title"]
            cell.label.text = title
            cell.imagv.image = UIImage(named: image!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = dataArr[indexPath.row]["title"]
        if title == "我的考勤"{
            let vc = MyAttendanceViewController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
        }else if title == "我的薪资"{
            let vc = MySalaryDetailsListController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = SetUpViewController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func headViewAction() {
        let vc = PersonalInformationPageController()
        UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
    }
    
    //获取用户信息
    func getURLUserInfoRequset() {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number] as [String : Any]
            let checkParms = [number]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_User_Info, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_User_Info:\(json)")
                    
                    let content = json["content"]
                    let code = json["code"].intValue
                    let msg = json["msg"].stringValue
                    if code == 200 {
//                        UserInfoModel.userData(content: content)
                        
                    }else{
                        
                    }
                    
                }
            } err: {[weak self] error in
                Dprint("URL_User_Info====== \(error)")
                self?.view.hideToastActivity()
            }
        }
    }
    
}
