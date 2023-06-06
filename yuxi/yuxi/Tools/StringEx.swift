//
//  StringEx.swift
//  Sheng
//
//  Created by DS on 2017/8/18.
//  Copyright © 2017年 First Cloud. All rights reserved.
//

import Foundation

extension String{
    /// 用来获取子字符串第一次或最后一次出现的位置索引
        ///
        /// - Parameters:
        ///   - sub: 子字符串
        ///   - backwards: 是否是获取最后一次出现的位置
        /// - Returns: 位置索引
        func positionOf(sub:String, backwards:Bool = false) -> Int? {
            var pos:Int?
            if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
                if !range.isEmpty {
                    pos = self.distance(from:startIndex, to:range.lowerBound)
                }
            }
            return pos
        }
        
        /// 取子字符串
        ///
        /// - Parameters:
        ///   - startIndex: 开始位置索引
        ///   - endIndex: 结束位置索引
        /// - Returns: 从开始位置到结束位置的前一个位置上的字符串
        func substring(startIndex:Int, endIndex:Int) -> String {
            let start = self.index(self.startIndex, offsetBy: startIndex)  //索引从开始偏移startIndex个位置
            let end = self.index(self.startIndex, offsetBy: endIndex)  //索引从开始偏移endIndex个位置
            let range = start..<end
            return String(self[range])//self.substring(with: range)
        }
    
    /// 获取指定行间距的字符串
    ///
    /// - Parameters:
    ///   - lineSpace: 行间距
    /// - Returns: 指定行间距的字符串
    func getLiSpaceAttriString(lineSpace:CGFloat
    ) -> NSAttributedString{
        let attriStr = NSMutableAttributedString(string: self)
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = lineSpace
        let range = NSMakeRange(0, (self as NSString).length)
        attriStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraStyle, range: range)
        return attriStr
    }
    
    /// 过滤非法字符
    ///
    /// - Returns: 过滤后的字符
    func bkyfilterInvaildChar() -> String {
        if self.count > 0 {
            let invaildCharArr:[Character] = ["\u{200f}","\u{0787}","\u{06af}","\u{0648}"]
            var hasInvaildChar = false
            for char in invaildCharArr{
                if self.firstIndex(of: char) != nil{
                    hasInvaildChar = true
                }
            }
            if hasInvaildChar == false{
                return self
            }
            if self == "\u{2666}\u{200f}\u{8a00}\u{535a}"{ //♦‏言博
                return "\u{8a00}\u{535a}\u{2666}"
            }
            if self == "\u{06af}\u{0648}\u{987e}\u{4e00}\u{724c}"{ //گو顾一牌
                return "\u{987e}\u{4e00}\u{724c}\u{06af}\u{0648}"
            }
            var resultStr = self
            for char in invaildCharArr{
                resultStr = resultStr.replacingOccurrences(of: String.init(char), with: "")
            }
            return resultStr
        }
        return self
    }
    
//    func bkyCheckfilterInvaildChar() -> Bool {
//        if self.count > 0 {
//            let keyWords = BKYSQLHelper.query(withCondition: self)
//            Dprint(keyWords)
//            if keyWords {
//                return true
//            }else{
//                return false
//            }
//            
//        }
//        return false
//    }
    
    
    
    /// 取子字符串
    ///
    /// - Parameters:
    ///   - startIndex: 开始位置索引
    ///   - endIndex: 结束位置索引
    /// - Returns: 从开始位置到结束位置的前一个位置上的字符串
    func substringWithBky(startInd:Int, endInd:Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startInd)  //索引从开始偏移startIndex个位置
        let end = self.index(self.startIndex, offsetBy: endInd)  //索引从开始偏移endIndex个位置
        let range = start..<end
        return self.substring(with: range)
    }
    
    /**获取字符串高度H*/
    func getNormalStrH(strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    /**获取字符串宽度W*/
    func getNormalStrW(strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    
    /**获取字符串尺寸--私有方法*/
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize.zero
        
    }
    
    /**获取富文本字符串高度H*/
    func getAttributedStrH(attriStr: NSMutableAttributedString, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    /**获取富文本字符串宽度W*/
    
    func getAttributedStrW(attriStr: NSMutableAttributedString, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    func numberValue() -> Int64 {
        guard let n = NumberFormatter().number(from: self) else { return 0}
        return Int64(n)
    }
    
    
    //密码正则  8-16位字母和数字组合
    func isPasswordRuler() -> Bool {
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        if regexPassword.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }
    
    //验证手机号
    func isPhoneNumber() -> Bool {
        if self.count == 0 {
            return false
        }
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }
    
    
}
