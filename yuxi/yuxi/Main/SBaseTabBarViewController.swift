//
//  SBaseTabBarViewController.swift
//  SoundLink
//
//  Created by sun on 2018/4/9.
//  Copyright © 2018年 Sound Link. All rights reserved.
//

import UIKit

class SBaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    var indexFlag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 9.0, *) {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            UISearchBar.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if let index = tabBar.items?.index(of: item) {
//            if indexFlag != index {
//                animationWithIndex(index: index)
//            }
//        }
    }
    
    func animationWithIndex(index: Int) {
        var arr = [UIView]()
        for tabBarButton in tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                for view in tabBarButton.subviews{
                     if view.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                        arr.append(view)
                    }
                }
//                arr.append(tabBarButton.value(forKey: "_info") as! UIView)
            }
        }
        var frame = arr[index].frame
        Dprint(frame)
        frame.origin.x -= CGFloat(2*YUXIIPONE_SCALE)
        frame.origin.y -= CGFloat(12*YUXIIPONE_SCALE)
        frame.size.width += CGFloat(4*YUXIIPONE_SCALE)
        frame.size.height += CGFloat(7*YUXIIPONE_SCALE)
        UIView.animate(withDuration: 0.2) {
            arr[index].frame = frame
        }
        
        //注释掉的代码  为放大缩小动画
//        let pulse = CABasicAnimation(keyPath: "transform.scale")
//        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        pulse.duration = 0.08
//        pulse.repeatCount = 1
//        pulse.autoreverses = true
//        pulse.fromValue = NSNumber(value: 0.7)
//        pulse.toValue = NSNumber(value: 1.3)
//        arr[index].layer.add(pulse, forKey: nil)
    
//        var valueArr = [CGImage]()
//        var tempArr = ["Sel_HOME_Layer-1","Sel_HOME_Layer-2","Sel_HOME_Layer-3","Sel_HOME_Layer-4"]
//
//        if index == 0 {
//            tempArr = ["Sel_HOME_Layer-1","Sel_HOME_Layer-2","Sel_HOME_Layer-3","Sel_HOME_Layer-4"]
//        }else if index == 1 {
//            tempArr = ["Sel_EXPLORE_Layer-1","Sel_EXPLORE_Layer-2","Sel_EXPLORE_Layer-3","Sel_EXPLORE_Layer-4"]
//        }else if index == 2 {
//            tempArr = ["Sel_MESSAGE_Layer-1","Sel_MESSAGE_Layer-2","Sel_MESSAGE_Layer-3","Sel_MESSAGE_Layer-4"]
//        }else if index == 3 {
//            tempArr = ["Sel_ME_Layer-1","Sel_ME_Layer-2","Sel_ME_Layer-3","Sel_ME_Layer-4"]
//        }
//        for item in tempArr {
//            valueArr.append( (UIImage.init(named: item)?.cgImage)!)
//        }
//        let pulse = CAKeyframeAnimation(keyPath: "contents")
//        pulse.values = valueArr
//        pulse.duration = 0.5
//        pulse.calculationMode = "discrete"
//        pulse.repeatCount = 1
//        pulse.isRemovedOnCompletion = true
//        pulse.fillMode = kCAFillModeForwards
//        arr[index].layer.add(pulse, forKey: nil)
        
        indexFlag = index
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
