//
//  SetUpViewController.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/11.
//

import UIKit
import SwiftyJSON

class SetUpViewController: YUXIBaseController, UITableViewDelegate, UITableViewDataSource {
   
    var dataStr = ["修改密码","隐私协议","服务协议","关于我们","退出登录"]
    
    lazy var tableView:UITableView = {
        let tbView = UITableView.init(frame: CGRect.zero, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .none
        tbView.register(SetUpCell.self, forCellReuseIdentifier: "SetUpCell")
        tbView.separatorStyle = .none
        return tbView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.YUXICreateNavbar(navTitle: "设置", leftImage: "L_back", rightStr: "", ringhtAction: nil,rightIsImage: true,titleIsRight:true)
        self.view.backgroundColor = YUXICOLOR(h: 0xF3F3F3, alpha: 1)
        
        setupUI()
        
    }
    
    func setupUI() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(YUXINEWNAVHEIGHT)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpCell", for: indexPath) as! SetUpCell
        cell.selectionStyle = .none
        cell.modelStr = dataStr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let string = dataStr[indexPath.row]
        switch string {
        case "修改密码":
            let vc = ChangePasswordViewController()
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case "隐私协议":
            let vc: FishingGameWebVC = FishingGameWebVC()
            vc.loadStr = "http://yxrlzy.cn/mobile/index/ysxy"
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case "服务协议":
            let vc: FishingGameWebVC = FishingGameWebVC()
            vc.loadStr = "http://yxrlzy.cn/mobile/index/fwxy"
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case "关于我们":
            let vc: FishingGameWebVC = FishingGameWebVC()
            vc.loadStr = "http://yxrlzy.cn/mobile/index/gywm"
            UIViewController.getCurrentViewCtrl().navigationController?.pushViewController(vc, animated: true)
            break
        case "退出登录":
            SRequestObject.shared.exitLoginInterface()
            break
        default:
            break
        }
        
        
    }
    //MARK: 接口请求
    
    
    

}
