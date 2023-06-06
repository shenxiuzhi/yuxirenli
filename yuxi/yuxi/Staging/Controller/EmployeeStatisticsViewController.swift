//
//  EmployeeStatisticsViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/30.
//

import UIKit
import SwiftyJSON

class EmployeeStatisticsViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: YUXISCREEN_HEIGHT - (YUXINEWNAVHEIGHT + WIDTH_SCALE(84))), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(EmployeeStatisticsCell.self, forCellReuseIdentifier: String(describing: EmployeeStatisticsCell.self))
        
        return tableView
    }()
    
    var dataArr:[EmployeeStaisticsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.YUXICreateNavbar(navTitle: "员工统计", leftImage: "L_back", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.navBarV.backgroundColor = .white
        self.view.backgroundColor = .white
        tableView.backgroundColor = YUXICOLOR(h: 0x000000, alpha: 0.1)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navBarV.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        setUserCoun()
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmployeeStatisticsCell.self)) as!EmployeeStatisticsCell
        cell.selectionStyle = .none
        if indexPath.row < dataArr.count {
            cell.model = dataArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(291*YUXIIPONE_SCALE)
    }
    
    func setUserCoun() {
        
        SURLRequest.sharedInstance.requestPostWithHeader(URL_User_Coun, param: nil, checkSum: []) { [weak self] (data) in
            if let weakself = self {
                let json = JSON(data)
                Dprint("URL_User_Coun:\(json)")
                let code = json["code"].intValue
                let content = json["data"]
                if code == 200 {
                    let agebook = content["agebook"]
                    let edubook = content["edubook"]
                    let spebook = content["spebook"]
                    let dutbook = content["dutbook"]
                    let agebookModel = EmployeeStaisticsModel.getUserdepData(json: agebook)
                    let edubookModel = EmployeeStaisticsModel.getUserdepData(json: edubook)
                    let spebookModel = EmployeeStaisticsModel.getUserdepData(json: spebook)
                    let dutbookModel = EmployeeStaisticsModel.getUserdepData(json: dutbook)
                    weakself.dataArr.append(agebookModel)
                    weakself.dataArr.append(edubookModel)
                    weakself.dataArr.append(spebookModel)
                    weakself.dataArr.append(dutbookModel)
                    
                }else {
                    
                }
                
                weakself.tableView.reloadData()
            }
        } err: {[weak self] error in
            Dprint("URL_User_Coun====== \(error)")
        }
        
        
        
    }
    
    
}
