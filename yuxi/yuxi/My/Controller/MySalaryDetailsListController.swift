//
//  MySalaryDetailsListController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/4.
//

import UIKit
import SwiftyJSON

class MySalaryDetailsListController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
    var headView = SalaryListHeaderView(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(119)))
    
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(SalaryListCell.self, forCellReuseIdentifier: "SalaryListCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    
    var detailsID:String = ""
    
    var dataArr:[MySalaryDetailsYaerListModel] = [] {
        didSet {
            if detailsID != "" {
                for item in dataArr {
                    if detailsID == String(item.book_id) {
                        let vc = SalaryDetailsController()
                        vc.model = item
                        UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    var yearString = Tools.dateConvertString(date: Date(), dateFormat: "yyyy") {
        didSet {
            setSalaryGetList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.YUXICreateNavbar(navTitle: "薪资明细", leftImage: "L_back", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.view.backgroundColor = YUXICOLOR(h: 0xF3F3F3, alpha: 1)
        tableView.tableHeaderView = headView
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        headView.yearBtnBlock = {[weak self] in
            if let weakself = self {
                weakself.dateSelection()
            }
        }
        
        setSalaryGetList() 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalaryListCell", for: indexPath) as! SalaryListCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        if indexPath.row < dataArr.count {
            cell.model = dataArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SalaryDetailsController()
        if indexPath.row < dataArr.count {
            vc.model = dataArr[indexPath.row]
        }
        UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
    }

    
    func setSalaryGetList() {
        if let number = UserInfo.mr_findFirst()?.number {
            dataArr.removeAll()
            let parms = ["u_code":number,"year":yearString] as [String : Any]
            let checkParms = [number,yearString]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Salary_GetList, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Salary_Info:\(json)")
                    let code = json["code"].intValue
                    let content = json["data"]
                    let total = content["total"].int64Value//年总工资
                    let list = content["list"].arrayValue
                    if code == 200 {
                        weakself.headView.incomeLab.text = "\(total)"
                        for js in list {
                            let model = MySalaryDetailsYaerListModel.getUserdepData(json: js)
                            weakself.dataArr.append(model)
                        }
                    }else{
                        
                    }
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Salary_Info====== \(error)")
            }
        }
    }
    
    func dateSelection() {
        
        let datePicker = YLDatePicker(currentDate: Date(), minLimitDate: Tools.getDataWithString(2010), maxLimitDate: Date(), datePickerType: .Y) { [weak self] (date) in
            if let weakself = self {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy"
                let newDate: String = dateformatter.string(from: date)
                weakself.yearString = newDate
                weakself.headView.yearBtn.setTitle(newDate+"年", for: .normal)
            }
        }
        datePicker.closeBlock = {[weak self] in
            
        }
        datePicker.show()
        
        
//        let dateView = TimeSelectorView.init(frame: UIViewController.getCurrentViewCtrl().view.bounds)
//        dateView.sendDate = { [weak self] (_ date: Date) -> Void in
//
//        }
//        UIViewController.getCurrentViewCtrl().view.addSubview(dateView)
    }

}
