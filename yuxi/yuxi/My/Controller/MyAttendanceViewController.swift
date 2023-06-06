//
//  MyAttendanceViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/15.
//

import UIKit
import CVCalendar
import SwiftyJSON

class MyAttendanceViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
    var headView = MyAttendanceHeaderView.init(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: WIDTH_SCALE(422)))
    
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(MyAttendanceCell.self, forCellReuseIdentifier: "MyAttendanceCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    
    let bgImagv = UIImageView()
    
    var dateTimeString = Tools.dateConvertString(date: Date(), dateFormat: "yyyy-MM-dd"){
        didSet {
            setAttendanceListinfo(date: dateTimeString)
        }
    }
    
    var month = Tools.dateConvertString(date: Date(), dateFormat: "yyyy-MM")
    
    var dataArr:[MyAttendanceModel] = []
    
    var checkedTotalStr = ""
    var checkedInStr = ""
    
    var calendarArr:[CalendarClockInModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpUI()
        
        
        setAttendanceListinfo(date: dateTimeString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dateY = Tools.dateConvertString(date: Date(), dateFormat: "yyyy")
        let dateM = Tools.dateConvertString(date: Date(), dateFormat: "MM")
        let str1 = dateM.substring(startIndex: 0, endIndex: 1)
        let str2 = dateM.substring(startIndex: 1, endIndex: 2)
        if str1 == "0" {
            getAttendanceGetCalendar(year: dateY, month:str2)
        }else {
            getAttendanceGetCalendar(year: dateY, month:dateM)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Commit frames' updates
        self.headView.calendarView.menuView.commitMenuViewUpdate()
        self.headView.calendarView.calendarView.commitCalendarViewUpdate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setUpUI() {
        let bgView = UIView()
        bgView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(WIDTH_SCALE(300))
        }
        
        bgImagv.image = UIImage(named: "Attendance_Seize_Seat_Bg")
        bgImagv.isUserInteractionEnabled = true
        self.view.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(WIDTH_SCALE(38))
            make.width.equalTo(WIDTH_SCALE(154))
            make.height.equalTo(WIDTH_SCALE(150.8))
        }
        
        self.YUXICreateNavbar(navTitle: "我的考勤", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.isNavBarClear = true
        
        tableView.tableHeaderView = headView
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        headView.monthlyReportBtn.addTarget(self, action: #selector(monthlyReportAction), for: .touchUpInside)
        headView.arrawBtn.addTarget(self, action: #selector(monthlyReportAction), for: .touchUpInside)
        
        headView.calendarView.selectDateCallback = { [weak self] (date) in
            if let weakself = self {
                // 创建一个日期格式器
                let dformatter = DateFormatter()
                dformatter.dateFormat = "yyyy年MM月dd日"
                weakself.setAttendanceListinfo(date: "")
                
            }
        }
        
        headView.calendarView.switchingMonthsClock = { [weak self] (year,month) in
            if let weakself = self {
                weakself.headView.dateLab.text = "\(year)|\(month)"
                weakself.dateTimeString = "\(year)-\(month)-01"
                let year1 = year.substring(startIndex: 0, endIndex: 4)
                let str1 = month.substring(startIndex: 0, endIndex: 1)
                let str2 = month.substring(startIndex: 1, endIndex: 2)
                weakself.month = year1+"-"+month.substring(startIndex: 0, endIndex: 2)
                if str1 == "0" {
                    weakself.getAttendanceGetCalendar(year: year1, month:str2)
                }else {
                    weakself.getAttendanceGetCalendar(year: year1, month:month)
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAttendanceCell", for: indexPath) as! MyAttendanceCell
        cell.selectionStyle = .none
        cell.modelArr = dataArr
        
        let resultStr = NSString.init(format: "已打卡%@/%@", checkedInStr,checkedTotalStr)
        let attriStr = NSMutableAttributedString.init(string: resultStr as String)
        attriStr.yy_color = YUXICOLOR(h: 0x000000, alpha: 1)
        attriStr.yy_font = UIFont.init(name: "PingFangSC-Regular", size: CGFloat(12 * YUXIIPONE_SCALE))
        attriStr.addAttribute(NSAttributedString.Key.foregroundColor, value:YUXICOLOR(h: 0x3FA9F5, alpha: 1) , range: resultStr.range(of: checkedInStr))
        cell.checkedInLab.attributedText = attriStr
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WIDTH_SCALE(192)
    }
    
    @objc func monthlyReportAction() {
        
        let vc = MyMonthlyReportCenterViewController()
        vc.month = self.month
        UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
        
    }
    
    var zci = 0
    var cci = 0
    func setAttendanceListinfo(date:String) {
        
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number,"date":date] as [String : Any]
            let checkParms = ["\(number)",date]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Attendance_Listinfo, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Attendance_Listinfo:\(json)")
                    let code = json["code"].intValue
                    let content = json["data"]
                    let time = content["time"].intValue//需要打卡次数
                    let qci = content["qci"].intValue//未打卡次数
                    weakself.zci = content["zci"].intValue//早退次数
                    weakself.cci = content["cci"].intValue//迟到次数
                    let list = content["ci"].arrayValue
                    weakself.checkedTotalStr = "\(time)"
                    weakself.checkedInStr = "\(list.count)"
                    weakself.dataArr.removeAll()
                    if code == 200 {
                        for js in list {
                            let model = MyAttendanceModel.getUserdepData(json: js)
                            weakself.dataArr.append(model)
                        }
                    }else{
                        
                    }
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Attendance_Listinfo====== \(error)")
            }
        }
    }
    //打卡日历
    func getAttendanceGetCalendar(year:String,month:String) {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["year":year,"month":month,"code":number] as [String : Any]
            let checkParms = [year,month,"\(number)"]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Attendance_GetCalendar, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Attendance_GetCalendar:\(json)")
                    let code = json["code"].intValue
                    let content = json["data"].arrayValue
                    if code == 200 {
                        for js in content {
                            let model = CalendarClockInModel.getUserdepData(json: js)
                            weakself.calendarArr.append(model)
                        }
                        weakself.headView.calendarView.calendarArr = weakself.calendarArr
                        //刷新日历视图（自动调用shouldShowOnDayView方法重新加载标记点）
                        weakself.headView.calendarView.calendarView.contentController.refreshPresentedMonth()
                    }else{
                        
                    }
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Attendance_GetCalendar====== \(error)")
            }
        }
    }
    
}
