//
//  AddressBookController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/5.
//

import UIKit
import SwiftyJSON

class AddressBookController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {

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
        tableView.register(AddressBookCell.self, forCellReuseIdentifier: String(describing: AddressBookCell.self))
        
        return tableView
    }()
    
    var dataArr:[AddressBookModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.YUXICreateNavbar(navTitle: "通讯录", leftImage: "L_back_width", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.isNavBarClear = true
        self.navBarV.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        setUserBook()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddressBookCell.self)) as!AddressBookCell
        cell.selectionStyle = .none
        if dataArr.count > indexPath.row{
            cell.model = dataArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(43*YUXIIPONE_SCALE)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var titleStr = ""
        var type = -1
        var tel = ""
        var modelArr:[AddressBookModel] = []
        if dataArr.count > indexPath.row{
            titleStr = dataArr[indexPath.row].name
            type = dataArr[indexPath.row].type
            tel = dataArr[indexPath.row].tel
            modelArr = dataArr[indexPath.row].json
        }
        if type == 0 {
            let vc = DepartmentListController()
            vc.titleStr = titleStr
            vc.dataArr = modelArr
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
        }else {
            UIApplication.shared.openURL(URL(string: "tel://\(tel)")! as URL)
        }
    }
    
    func setUserBook() {
        SURLRequest.sharedInstance.requestPostWithHeader(URL_User_Book, param: nil, checkSum: []) { [weak self] (data) in
            if let weakself = self {
                let json = JSON(data)
                Dprint("URL_User_Book:\(json)")
                let code = json["code"].intValue
                let content = json["data"].arrayValue
                if code == 200 {
                    for js in content {
                        let model = AddressBookModel.getUserdepData(json: js)
                        weakself.dataArr.append(model)
                    }
                }else {
                    
                }
                weakself.tableView.reloadData()
            }
        } err: {[weak self] error in
            Dprint("URL_User_Book====== \(error)")
        }
    }
    
    
}
