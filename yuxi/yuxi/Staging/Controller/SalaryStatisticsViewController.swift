//
//  SalaryStatisticsViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/16.
//

import UIKit
import SwiftyJSON

class SalaryStatisticsViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
    var headView = SalaryStatisticsHeadView(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(130)))
    
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(SalaryStatisticsCell.self, forCellReuseIdentifier: "SalaryStatisticsCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    
    var selectedDate = ""
    
    var dataArr:[SalarStatisticsListModel] = []
    
    var dateTimeString = Tools.dateConvertString(date: Date(), dateFormat: "yyyy"){
        didSet {
            setSalaryInfo(year: dateTimeString)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = YUXICOLOR(h: 0xF3F3F3, alpha: 1)
        
        let topBgView = UIView()
        topBgView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.view.addSubview(topBgView)
        topBgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(400))
        }
        let bgImagv = UIImageView()
        bgImagv.image = UIImage(named: "Attendance_Seize_Seat_Bg")
        bgImagv.isUserInteractionEnabled = true
        self.view.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(WIDTH_SCALE(38))
            make.width.equalTo(WIDTH_SCALE(154))
            make.height.equalTo(WIDTH_SCALE(150.8))
        }
        
        self.YUXICreateNavbar(navTitle: "薪资统计", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: false,titleIsRight:false)
        self.isNavBarClear = true
        
        setUpUI()
        setSalaryInfo(year: dateTimeString)
    }
    
    func setUpUI() { 
        tableView.tableHeaderView = headView
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        headView.dateSelection = {
           
            let datePicker = YLDatePicker(currentDate: Date(), minLimitDate: Tools.getDataWithString(2010), maxLimitDate: Date(), datePickerType: .Y) { [weak self] (date) in
                if let weakself = self {
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "yyyy"
                    let newDate: String = dateformatter.string(from: date)
                    weakself.selectedDate = newDate
                    weakself.headView.yearBtn.setTitle(newDate+"年", for: .normal)
                    weakself.dateTimeString = newDate
                }
            }
            datePicker.closeBlock = {[weak self] in
                
            }
            datePicker.show()
            
//            let dateView = TimeSelectorView.init(frame: UIViewController.getCurrentViewCtrl().view.bounds)
//            dateView.sendDate = { [weak self] (_ date: Date) -> Void in
//
//            }
//            UIViewController.getCurrentViewCtrl().view.addSubview(dateView)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalaryStatisticsCell", for: indexPath) as! SalaryStatisticsCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        if indexPath.row < dataArr.count {
            cell.model = dataArr[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WIDTH_SCALE(236)
    }
    
    func setSalaryInfo(year:String) {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["year":year,"u_code":number] as [String : Any]
            let checkParms = [year,number]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Gather_Info, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Gather_Info:\(json)")
                    let code = json["code"].intValue
                    let salary = json["data"]["salary"]
                    let bonus = json["data"]["bonus"]
                    weakself.dataArr.removeAll()
                    if code == 200 {
                        let salaryModel = SalarStatisticsListModel.getUserdepData(json: salary)
                        weakself.dataArr.append(salaryModel)
                        let bonusModel = SalarStatisticsListModel.getUserdepData(json: bonus)
                        weakself.dataArr.append(bonusModel)
                        
                        weakself.headView.totalSalarySumLab.text = "\(salary["sum"].floatValue)\(salary["unit"].stringValue)"
                        weakself.headView.totalBonusSumLab.text = "\(bonus["sum"].floatValue)\(bonus["unit"].stringValue)"
                    }else{

                    }
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Salary_Info====== \(error)")
            }
        }
    }
    

}
