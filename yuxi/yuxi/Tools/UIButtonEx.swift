//
//  UIButtonEx.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/6.
//
import UIKit
import Foundation


// MARK: - UIButton扩展类
extension UIButton {
    
    //UIButton 文本增加下划线
    func underline() {
        guard let text = self.titleLabel?.text else { return }
 
        let attributedString = NSMutableAttributedString(string: text)
 
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
 
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    
    
}
