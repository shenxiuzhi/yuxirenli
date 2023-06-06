//
//  UIViewControllerEx.swift
//  Sheng
//
//  Created by DS on 2017/7/19.
//  Copyright © 2017年 mac. All rights reserved.
//

/*
 UIViewController类扩展
 */
import UIKit
import Foundation

extension UIViewController{
    
    /// 使嵌入的横向滚动视图不影响控制器的拖返功能
    ///
    /// - Parameter scrollV: 嵌入的横向滚动视图,它也可能是UICollectionView或UITableView
    func notDistrubSlipBack(with scrollV:UIScrollView) {
        if let gestureArr = self.navigationController?.view.gestureRecognizers{
            for gesture in gestureArr {
                if (gesture as AnyObject).isKind(of:UIScreenEdgePanGestureRecognizer.self){
                    scrollV.panGestureRecognizer.require(toFail: gesture)
                }
            }
        }
    }
    
    /// 获取当前视图控制器
    ///
    /// - Returns: 当前视图控制器
    @objc class func getCurrentViewCtrl()->UIViewController{
        var window = UIApplication.shared.keyWindow  //.keywindow must be used from main thread only
        if window?.windowLevel != UIWindow.Level.normal {  //.windowLevel
            let windows = UIApplication.shared.windows
            for subWin in windows {
                if subWin.windowLevel == UIWindow.Level.normal {
                    window = subWin
                    break
                }
            }
        }
        if let frontView = window?.subviews.first{   //.subviews
            let nextResponder = frontView.next  //.next
            if let tabbarCtrl = nextResponder as? UITabBarController{
                if let selectedCtrl = tabbarCtrl.selectedViewController{
                    if let navCtrl = selectedCtrl as? BaseNavigationController {
                        return UIViewController.getCurrentViewCtrl(navCtrl: navCtrl)
                    }else{
                        return selectedCtrl
                    }
                }else{
                    if let firstCtrl = tabbarCtrl.viewControllers?.first{
                        return firstCtrl
                    }else{
                        return tabbarCtrl
                    }
                }
            }else if let navCtrl = nextResponder as? BaseNavigationController{
                return UIViewController.getCurrentViewCtrl(navCtrl: navCtrl)
            }else if let viewCtrl = nextResponder as? UIViewController{
                return viewCtrl
            }
        }
        let windowCtrl = window?.rootViewController
        if let tabbarCtrl = windowCtrl as? UITabBarController{
            if let selectedCtrl = tabbarCtrl.selectedViewController {
                if let navCtrl = selectedCtrl as? BaseNavigationController {
                    tabbarCtrl.hidesBottomBarWhenPushed = false
                    return UIViewController.getCurrentViewCtrl(navCtrl: navCtrl)
                }else{
                    return selectedCtrl
                }
            }else{
                if let firstCtrl = tabbarCtrl.viewControllers?.first{
                    return firstCtrl
                }else{
                    return tabbarCtrl
                }
            }
        }else if let navCtrl = windowCtrl as? BaseNavigationController{
            return UIViewController.getCurrentViewCtrl(navCtrl: navCtrl)
        }else{
            return windowCtrl!
        }
    }

    /// 简单的loading
    ///
    /// - Parameter isShow: 是否显示
    class func centerToastActivity(isShow:Bool) {
        let curVC = UIViewController.getCurrentViewCtrl()
        if isShow {
            curVC.view.makeToastActivity(.center)
        }else{
            curVC.view.hideToastActivity()
        }
        
    }
    
    /// 简单的toast
    ///
    /// - Parameter message: 提示内容
    @objc class func bottomToast(message:String) {
        let curVC = UIViewController.getCurrentViewCtrl()
        curVC.view.makeToast(message, duration: 1.6, position: .center)
    }
    
    @objc class func centerToast(message:String, duration:Double = 1.5) {
        let curVC = UIViewController.getCurrentViewCtrl()
        curVC.view.makeToast(message, duration: duration, position: .center)
    }
    
    // MARK: - private
    fileprivate class func getCurrentViewCtrl(navCtrl:BaseNavigationController) -> UIViewController {
        if let visibleCtrl = navCtrl.visibleViewController{
            if let tabbarCtrl = visibleCtrl as? UITabBarController{
                return UIViewController.getCurrentViewCtrl(subTabbarCtrl:tabbarCtrl)
            }else{
                return visibleCtrl
            }
        }else{
            if let firstCtrl = navCtrl.viewControllers.first{
                return firstCtrl
            }else{
                return navCtrl
            }
        }
    }
    
    fileprivate class func getCurrentViewCtrl(subTabbarCtrl:UITabBarController) -> UIViewController {
        if let selectedCtrl = subTabbarCtrl.selectedViewController{
            if let subNavCtrl = selectedCtrl as? BaseNavigationController {
                if let subVisibleCtrl = subNavCtrl.visibleViewController{
                    return subVisibleCtrl
                }else{
                    if let firstCtrl = subNavCtrl.viewControllers.first{
                        return firstCtrl
                    }else{
                        return subNavCtrl
                    }
                }
            }else{
                return selectedCtrl
            }
        }else{
            if let firstCtrl = subTabbarCtrl.viewControllers?.first{
                return firstCtrl
            }else{
                return subTabbarCtrl
            }
        }
    }

}
