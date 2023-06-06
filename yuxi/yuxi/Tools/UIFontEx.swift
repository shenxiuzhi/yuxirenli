//
//  UIFontEx.swift
//  bkvoice
//
//  Created by Kevin on 2022/10/19.
//  Copyright © 2022 bkvoice. All rights reserved.
//

import UIKit
import Foundation
// MARK: - UIView类别
enum fontStyle {
    case Regular, Medium, Semibold
}

extension UIFont{
    class func fontWith(_ fontStyle:fontStyle? = .Regular, size:CGFloat)->UIFont{
        switch fontStyle {
        case .Regular:
            return UIFont.init(name: "PingFangSC-Regular", size: IPHONESEC(size))!
        case .Medium:
            return UIFont.init(name: "PingFangSC-Medium", size: IPHONESEC(size))!
        case .Semibold:
            return UIFont.init(name: "PingFangSC-Semibold", size: IPHONESEC(size))!
        default:
            return UIFont.init(name: "PingFangSC-Regular", size: IPHONESEC(size))!
        }
    }
    
}
