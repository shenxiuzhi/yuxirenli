//
//  STabbarController.swift
//  Sheng
//
//  Created by DS on 2018/6/7.
//  Copyright © 2018年 First Cloud. All rights reserved.
//

import UIKit

class STabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 强制横屏辅助方法
    override var shouldAutorotate: Bool {
        get{
            if self.selectedIndex == 1{
                if let result = self.selectedViewController?.shouldAutorotate{
                    return result
                }
            }
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            if self.selectedIndex == 1{
                if let result = self.selectedViewController?.supportedInterfaceOrientations{
                    return result
                }
            }
            return .portrait
        }
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get{
            if self.selectedIndex == 1{
                if let result = self.selectedViewController?.preferredInterfaceOrientationForPresentation{
                    return result
                }
            }
            return .portrait
        }
    }

}
