//
//  AttendanceClockInViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/28.
//

import UIKit
import AMapLocationKit
import SwiftyJSON
import MagicalRecord
import Alamofire
import MobileCoreServices
import AVKit
import MediaPlayer

import CoreLocation


class AttendanceClockInViewController: YUXIBaseController, AMapLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    let locationManager2 = AMapLocationManager()
    var location:CLLocation!
    var keyWord:String!
    
    let bgImagv = UIImageView()
    
    var headView = AttendanceClockInHeaderView.init(frame: CGRect(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: YUXISCREEN_HEIGHT-YUXINEWNAVHEIGHT-YUXITabbarHeight+WIDTH_SCALE(20)))
    
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
     
    // 0:可以打卡 , 1:不在范围内, 2:不在时间内
    var isInScope:Int = -1 {
        didSet {
            headView.tipLab.text = isInScope == 2 ? "不在考勤打卡时间范围内" : (isInScope == 0 ? "已进入考勤范围，请点击按钮拍照打卡" : "不在打卡范围，无法打卡")
            headView.tipLab.textColor = YUXICOLOR(h: isInScope == 0 ? 0x3FA9F5 : 0x666666, alpha: 1)
            headView.tipImage.image = UIImage(named: isInScope == 0 ? "Attendance_Clock_In_Locate" : "Attendance_Out_Of_Range")
        }
    }
    
    var luckyTimer : Timer?
    
    var model = AttendanceClockInModel(){
        didSet{
            isTimeFrame = model.onoroff == 0 ? false : true
        }
    }
    
    var attendanceModel:[MyAttendanceModel] = []{
        didSet {
            headView.dataArr = attendanceModel
        }
    }
    
    //相差距离
    var differenceDistance:Double = 0.0 {
        didSet {
            if !isTimeFrame {
                isInScope = 2
            }else {
                if differenceDistance < model.range {
                    isInScope = 0
                }else {
                    isInScope = model.is_address == 0 ? 0 : 1
                }
            }
        }
    }
    
    let π: Double = 3.14159265358979324
    let ee: Double = 0.00669342162296594323
    let a: Double = 6378245.0
    
    var accuracy:String = ""
    var finalLat:Double = 0.0
    var finalLon:Double = 0.0 {
        didSet {
            if finalLon == 0.0 {
                differenceDistance = 0.0
            }else {
                differenceDistance = getDistance(lat1: model.lat, lng1: model.lon, lat2: finalLat, lng2: finalLon)
            }
            
        }
    }
    //是否在时间范围内
    var isTimeFrame = false
    
    //所需打卡次数
    var time:Int = 0 {
        didSet {
            headView.time = time
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bgImagv.image = UIImage(named: "Attendance_Clock_In_Bg")
        bgImagv.isUserInteractionEnabled = true
        self.view.addSubview(bgImagv)
        bgImagv.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        self.YUXICreateNavbarLeft(navTitle: "玉溪人力资源", navTitleColorIsWidth: false)
        self.isNavBarClear = true
        self.YUXInavTitleL.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        
        
        setUI()
        getAttendanceIndex()
        startTimer()
        setOnceLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let profile = UserInfo.mr_findFirst()?.avatar {
            headView.userProfileImagv.sd_setImage(with: URL.init(string: PYADDRESS_URL + profile))
        }
        if let username = UserInfo.mr_findFirst()?.username {
            headView.userNickLab.text = "Hi,"+username
        }
        if let dep = UserInfo.mr_findFirst()?.dep {
            headView.userGroupingLab.text = dep
        }
        
        getAttendanceIndex()
        setAttendanceListinfo()
    }
    
    func setUI() {
        
        headView.clockInBnt.addTarget(self, action: #selector(clockInAction), for: .touchUpInside)
        tableView.tableHeaderView = headView
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(YUXINEWNAVHEIGHT)
            make.bottom.equalToSuperview().offset(-YUXITabbarHeight)
        }
        tableViewHeader()
    }
    
    //下拉刷新
    func tableViewHeader(){
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.tableView.mj_header?.endRefreshing()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        return cell
    }
    
    
    ///开始计时
    func startTimer() {
        if luckyTimer == nil{
            luckyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        }
        //调用fire()会立即启动计时器
        luckyTimer?.fire()
    }
    
    ///定时操作
    @objc func updataSecond() {
        let aaa = Tools.currwntDateToTimeStamp() + 1
        let sss = Tools.timeStampToString(timeStamp: Double(aaa), dateFormat: "HH:mm:ss")
        //0 不再打卡时间范围 1：第一次上班打卡 2：第一次下班打卡3：第二次上班打卡 4：第二次下班打卡
        if model.onoroff == 0 {
            headView.clockInBnt.setTitle("\(sss)", for: .normal)
//            headView.clockInBnt.isEnabled = false
        }else if model.onoroff == 1{
            headView.clockInBnt.setTitle("上班打卡\n\(sss)", for: .normal)
//            headView.clockInBnt.isEnabled = true
        }else if model.onoroff == 2{
            headView.clockInBnt.setTitle("下班打卡\n\(sss)", for: .normal)
//            headView.clockInBnt.isEnabled = true
        }else if model.onoroff == 3{
            headView.clockInBnt.setTitle("上班打卡\n\(sss)", for: .normal)
//            headView.clockInBnt.isEnabled = true
        }else if model.onoroff == 4{
            headView.clockInBnt.setTitle("下班打卡\n\(sss)", for: .normal)
//            headView.clockInBnt.isEnabled = true
        }
        
    }
    
    
    //MARK:单次定位获取当前城市
    func setOnceLocation(){
        //高德定位初始化
        //精度
        self.locationManager2.desiredAccuracy = 5
        self.locationManager2.distanceFilter = 5
        //   定位超时时间，最低2s，此处设置为11s
        self.locationManager2.locationTimeout = 5
        //   逆地理请求超时时间，最低2s，此处设置为12s
        self.locationManager2.reGeocodeTimeout = 6
        self.locationManager2.delegate = self
//        locationManager2.pausesLocationUpdatesAutomatically = false
//        locationManager2.allowsBackgroundLocationUpdates = true
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if UIDevice.current.systemVersion._bridgeToObjectiveC().doubleValue >= 9.0 {
            locationManager.pausesLocationUpdatesAutomatically = true
        }
        locationManager2.locatingWithReGeocode = true
        //开始持续定位
        locationManager2.startUpdatingLocation()

//        self.locationManager2.requestLocation(withReGeocode: true) { (location, regeocode, error) in
//            if (error == nil){
//                print("高德可以定位")
////                self.location = location
////
////                self.keyWord = regeocode!.city
////
////                print(location?.coordinate.longitude ?? 0.00)
////
////                print(location?.coordinate.latitude ?? 0.00)
//            }
//        }
        
        
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 1
        //发送授权申请
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates=true
        // 进入后台后不停止
        locationManager.pausesLocationUpdatesAutomatically = false
        print("视图加载")
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            //                    locationManager.startUpdatingLocation()
            print("可以定位")
            startRequestLocation()
        }
    }
    
    // 开始尝试获取定位
    public func startRequestLocation() {
        if (self.locationManager != nil) && (CLLocationManager.authorizationStatus() == .denied) {
            // 没有获取到权限，再次请求授权
            print("拒绝授权")
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            print("开始定位")
            locationManager.startUpdatingLocation()
        }
    }
   
    // 代理方法，当定位授权更新时回调
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("授权变化")
        // CLAuthorizationStatus
        // .notDetermined   用户还没有选择授权
        // .restricted   应用没有授权用户定位
        // .denied 用户禁止定位
        // .authorizedAlways 用户授权一直可以获取定位
        // .authorizedWhenInUse 用户授权使用期间获取定位
        // TODO...
        if status == .notDetermined {
            //未授予
            self.view.makeToast("定位未授予")
        } else if (status == .restricted) {
            // 受限制，尝试提示然后进入设置页面进行处理
            self.view.makeToast("定位受限制，尝试提示然后进入设置页面进行处理")
        } else if (status == .denied) {
            // 被拒绝，尝试提示然后进入设置页面进行处理
            self.view.makeToast("定位被拒绝，尝试提示然后进入设置页面进行处理")
        }else{
            startRequestLocation()
        }
    }
    
    // 当获取定位出错时调用
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 这里应该停止调用api
        print(error)
        print(error.localizedDescription)
        print("定位失败")
        self.locationManager.stopUpdatingLocation()
    }
    
    //高德代理
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode?) {
        print("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy);};")
        finalLat = location.coordinate.latitude
        finalLon = location.coordinate.longitude

        if let reGeocode = reGeocode {

            print("reGeocode =======\(reGeocode)")
            let data = reGeocode.formattedAddress
            accuracy = reGeocode.formattedAddress
            print("reGeocode.formattedAddress ==== \(data)")
        }
//        getAttendanceIndex()
    }
    /// 权限检测
    private func locationPermissionsCheck(){
        if CLLocationManager.locationServicesEnabled() == false {
            self.view.makeToast("请确认已开启定位服务")
            return
        }
        
        // 请求用户授权
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    
    @objc func clockInAction() {
        if isInScope == 1 {
            self.view.makeToast("您不在打卡位置范围内")
            return
        }else if isInScope == 2 {
            self.view.makeToast("您不在打卡时间范围内")
            return
        }else {
            if Tools.IsOpenLocation() {
                
            }else{
                let view = PermissionClosedTipView()
                view.show()
                return
            }
        }
        
        SImagePickerObject.shared.showCamera(allowEdit: false)
        SImagePickerObject.shared.finishPickingBlock = { (image,imagePath,imageFormat) in

            if let number = UserInfo.mr_findFirst()?.number {
                let date = Tools.currwntDateToTimeStamp()
                let parms = ["code":number,"lat":"\(self.finalLat)","lon":"\(self.finalLon)","address":self.accuracy,"current":date] as [String : Any]
                Tools.uploads(apiName: URL_Attendance_Punch, method: .post,params: parms, images: image) { josn in
                    Dprint(josn)
//                    let code = josn["code"].intValue
                    let msg = josn["msg"].stringValue
                    self.setAttendanceListinfo()
                    UIViewController.getCurrentViewCtrl().view.hideToastActivity()
                    UIViewController.getCurrentViewCtrl().view.makeToast(msg)
                } fail: { fail in
                    Dprint(fail)
                    UIViewController.getCurrentViewCtrl().view.hideToastActivity()
                }
            }
        }
    }
   
    
    ///
    func getAttendanceIndex() {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number] as [String : Any]
            let checkParms = [number]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Attendance_Index, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    let datajs = json["data"]
                    Dprint("URL_Attendance_Index:\(json)")
                    weakself.model = AttendanceClockInModel.getUserdepData(json: datajs)
//                    weakself.getTimeFrame(modelArr: model.timeci)
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Attendance_Index====== \(error)")
            }
        }
    }
    
    //员工打卡详情
    func setAttendanceListinfo() {
        let date = Tools.dateConvertString(date: Date(), dateFormat: "yyyy-MM-dd")
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number,"date":date] as [String : Any]
            let checkParms = ["\(number)",date]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Attendance_Listinfo, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Attendance_Listinfo:\(json)")
                    let code = json["code"].intValue
                    let content = json["data"]
                    weakself.time = content["time"].intValue//需要打卡次数
                    let qci = content["qci"].intValue//未打卡次数
                    let list = content["ci"].arrayValue
                    weakself.attendanceModel.removeAll()
                    if code == 200 {
                        for js in list {
                            let model = MyAttendanceModel.getUserdepData(json: js)
                            weakself.attendanceModel.append(model)
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
    
    func getDistance(lat1:Double,lng1:Double,lat2:Double,lng2:Double) -> Double {
        let locationOne = CLLocation(latitude: lat1, longitude: lng1)
        let locationTwo = CLLocation(latitude: lat2, longitude: lng2)
        let distance = locationOne.distance(from: locationTwo)
        return distance
    }
//
//    func getTimeFrame(modelArr:[timeciModel]) {
//        for model in modelArr {
//
//        }
//
//    }
    
}

