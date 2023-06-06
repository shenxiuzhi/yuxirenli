//
//  SalaryDetailsController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit
import SwiftyJSON

class SalaryDetailsController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
    var headView = SalaryDetailsHeaderView.init(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(180)))
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(SalaryDetailsCell.self, forCellReuseIdentifier: "SalaryDetailsCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    
    var image = UIImageView()
    
    var model = MySalaryDetailsYaerListModel() {
        didSet {
            setSalaryInfo(model:model)
        }
    }
    
    var dataArr:[MySalaryDetailsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.YUXICreateNavbar(navTitle: "薪资详情", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.navBarV.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.YUXInavTitleL.textColor = .white
        self.view.backgroundColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        
        image.image = UIImage(named: "Salary_Details_Decoration_Bg")
        self.view.addSubview(image)
        image.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-YUXIIPHONEX_BH)
            make.height.equalTo(WIDTH_SCALE(189))
            make.width.equalTo(WIDTH_SCALE(193))
        }
        tableView.tableHeaderView = headView
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalaryDetailsCell", for: indexPath) as! SalaryDetailsCell
        cell.selectionStyle = .none
        if indexPath.row < dataArr.count {
            cell.model = dataArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WIDTH_SCALE(930)
    }
    
    func setSalaryInfo(model:MySalaryDetailsYaerListModel) {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["u_code":number,"book_id":model.book_id] as [String : Any]
            let checkParms = ["\(number)","\(model.book_id)"]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Salary_Info, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Salary_Info:\(json)")
                    let code = json["code"].intValue
                    let content = json["data"]
                    if code == 200 {
                        let model = MySalaryDetailsModel.getUserdepData(json: content)
                        weakself.headView.model = model
                        weakself.dataArr.append(model)
                        
                    }else{
                        
                    }
//                    weakself.tableView.mj_header?.endRefreshing()
//                    weakself.tableView.mj_footer?.endRefreshing()
//                    weakself.tableView.mj_footer?.isHidden = (content.count < dataCount)
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Salary_Info====== \(error)")
            }
        }
    }
    
    
}
