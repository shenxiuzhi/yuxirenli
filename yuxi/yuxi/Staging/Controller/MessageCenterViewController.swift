//
//  MessageCenterViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/12.
//

import UIKit
import SwiftyJSON

class MessageCenterViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
    
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
        tableView.register(MessageCenterListCell.self, forCellReuseIdentifier: String(describing: MessageCenterListCell.self))
        
        return tableView
    }()
    
    var dataArr:[MessageCenterListModel] = []
    
    var offset:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.YUXICreateNavbar(navTitle: "消息中心", leftImage: "L_back", rightStr: "全部已读", ringhtAction: #selector(allReadAction),rightIsImage: false,titleIsRight:true)
        self.YUXInavTitleL.textColor = YUXICOLOR(h: 0x000000, alpha: 1)
        self.view.backgroundColor = YUXICOLOR(h: 0xFFFFFF, alpha: 1)
        
        setUpUI()
        setMessageList(offset: 0)
    }
    
    func setUpUI() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(YUXINEWNAVHEIGHT)
        }
        
        tableViewHeader()
        tableViewFooter()
    }
    
    //下拉刷新
    func tableViewHeader(){
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.offset = 0
            self.setMessageList(offset: self.offset)
        })
    }
    
//    //上拉加载
    func tableViewFooter(){
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.offset += 1
            self.setMessageList(offset: self.offset * dataCount)
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageCenterListCell.self)) as!MessageCenterListCell
        cell.selectionStyle = .none
        if indexPath.row < dataArr.count {
            cell.model = dataArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(57*YUXIIPONE_SCALE)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MessageDetailsViewController()
        if indexPath.row < dataArr.count {
            vc.model = dataArr[indexPath.row]
        }
        UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
    }
    
    func setMessageList(offset:Int) {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number,"status":0,"page":offset,"size":dataCount] as [String : Any]
            let checkParms = ["\(number)","\(0)","\(offset)","\(dataCount)"]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Message_List, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Message_List:\(json)")
                    let code = json["code"].intValue
                    if offset == 0 {
                        weakself.dataArr.removeAll()
                    }
                    let content = json["data"].arrayValue
                    if code == 200 {
                        for js in content {
                            let model = MessageCenterListModel.getUserdepData(json: js)
                            weakself.dataArr.append(model)
                        }
                    }else{
                        
                    }
                    weakself.tableView.mj_header?.endRefreshing()
                    weakself.tableView.mj_footer?.endRefreshing()
                    weakself.tableView.mj_footer?.isHidden = (content.count < dataCount)
                    weakself.tableView.reloadData()
                }
            } err: {[weak self] error in
                Dprint("URL_Message_List====== \(error)")
            }
        }
    }
    
    @objc func allReadAction() {
        setMessageAll()
    }
    
    func setMessageAll() {
        if let number = UserInfo.mr_findFirst()?.number {
            let parms = ["code":number] as [String : Any]
            let checkParms = [number]
            SURLRequest.sharedInstance.requestPostWithHeader(URL_Message_All, param: parms, checkSum: checkParms) { [weak self] (data) in
                if let weakself = self {
                    let json = JSON(data)
                    Dprint("URL_Message_List:\(json)")
                    let code = json["code"].int64Value
                    let msg = json["msg"].stringValue
                    if code == 200 {
                        UIViewController.getCurrentViewCtrl().view.makeToast(msg,position: .center)
                        weakself.setMessageList(offset: 0)
                    }else {
                        UIViewController.getCurrentViewCtrl().view.makeToast(msg,position: .center)
                    }
                }
            } err: {[weak self] error in
                Dprint("URL_Attendance_Index====== \(error)")
            }
        }
    }

}
