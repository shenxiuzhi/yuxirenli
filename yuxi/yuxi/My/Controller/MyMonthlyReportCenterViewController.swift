//
//  MyMonthlyReportCenterViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/16.
//

import UIKit
import SwiftyJSON

class MyMonthlyReportCenterViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
    var headView = MyMonthlyReportCenterHeaderView.init(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(465)))
    
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = YUXICOLOR(h: 0xF3F3F3, alpha: 1)
        
        
        
        self.YUXICreateNavbar(navTitle: "我的月报", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.isNavBarClear = true
        self.navBarV.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        
        
        setUpUI()

    }
    
    func setUpUI() {
        tableView.tableHeaderView = headView
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navBarV.snp.bottom)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        return cell
    }
    
    var month:String = "" {
        didSet {
            headView.monthLab.text = month.substring(startIndex: 5, endIndex: 7)+"月"
            setAttendanceMonth()
        }
    }
    
    func setAttendanceMonth() {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["month":month,"code":number] as [String : Any]
            let checkParms = [month,number]
            Dprint("parms========:\(parms)")
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Attendance_Month, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Attendance_Month:\(json)")
                    let code = json["code"].intValue
                    let content = json["data"]
                    if code == 200 {
                        let model = MyMonthlyReportCenterModel.getUserdepData(json: content)
                        weakself.headView.model = model
                    }else{
                        
                    }
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Attendance_Month====== \(error)")
            }
        }
    }
    

}
