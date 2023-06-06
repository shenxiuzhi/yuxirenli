//
//  UIImageEx.swift
//  Sheng
//
//  Created by DS on 2017/8/15.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation
import Accelerate
//import SDWebImageWebPCoder
import YYImage

extension UIImage{
    
    /// webp图片资源转图片(依赖于SDWebImage/WebP库)
    ///
    /// - Parameter name: 图片资源名称
    /// - Returns: 图片
    class func webpResourceWebpToImage(name: String) -> UIImage? {
//        guard let path = Bundle.main.path(forResource: name, ofType: "webp") else {return nil}
//        guard let data = NSData.init(contentsOfFile: path) else {return nil}
////        //        let image = UIImage.sd_image(withWebPData: data as Data)
//        let image = SDImageWebPCoder.shared.decodedImage(with: data as Data, options: nil)
////        let image = YYImage(named: "\(name).webp")
//
//        return image
        let image = YYImage(named: "\(name).webp")
        return image
    }
    
    class func gifResourceWebpToImage(name: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: name, ofType: "webp") else {return nil}
        guard let data = NSData.init(contentsOfFile: path) else {return nil}
        //        let image = UIImage.sd_image(withWebPData: data as Data)
        let image = UIImage.sd_image(withGIFData: data as Data)
        return image
        
    }
    
    
    /// webp图片资源转图片(依赖于SDWebImage/WebP库)
    ///
    /// - Parameter name: 图片资源名称
    /// - Returns: 图片
//    class func webpResourceWebpYYToImage(name: String) -> UIImage? {
//        guard let path = Bundle.main.path(forResource: name, ofType: "webp") else {return nil}
//        guard let data = NSData.init(contentsOfFile: path) else {return nil}
//        //        let image = UIImage.sd_image(withWebPData: data as Data)
//        let decoder = YYImageDecoder.init(data: data as Data, scale: 2.0)
//        
//        let image = decoder.
//        return image
//        
//    }
    
    /// 拉伸图片(四角不拉伸,只拉伸边长的中心区段)
    ///
    /// - Parameter sscale: 边长中心区段的拉伸比例
    /// - Returns: 拉伸后的图片
    func stretchableImage(centerStretchScale sscale:CGFloat) -> UIImage {
        let leftRight = (self.size.width - self.size.width * sscale)/2.0
        let topBottom = (self.size.height - self.size.height * sscale)/2.0
        return self.resizableImage(withCapInsets: UIEdgeInsets.init(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight), resizingMode: .stretch)
    }
    
    /// 压缩图片到指定宽度
    ///
    /// - Parameter toWidth: 压缩后的宽度
    /// - Returns: 压缩后的图片
    func compressToScaleSize(toWidth:CGFloat) -> UIImage {
        var toSize = self.size
        if self.size.width > toWidth {
            toSize.height = toSize.height * toWidth/toSize.width
            toSize.width = toWidth
        }
        UIGraphicsBeginImageContext(toSize)
        self.draw(in: CGRect.init(origin: .zero, size: toSize))
        let newImage  = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /// 更改图片颜色
    func changeToTintColor(color:UIColor) -> UIImage{
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    /// 创建指定颜色的图片
    ///
    /// - Parameter color: 图片颜色
    /// - Returns: 图片
    class func createImageWithUIColor(color:UIColor, size: CGSize = CGSize.init(width: 3, height: 3)) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        if let content = UIGraphicsGetCurrentContext(){
            content.setFillColor(color.cgColor)
            content.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
    
    /// 传入图片image回传对应的base64字符串(默认不带有data标识)
    ///
    /// - Parameters:
    ///   - headerSign: 是否添加数据头
    /// - Returns: 对应的base64字符串
    func imageToBase64String(headerSign:Bool = false)->String?{
        
        ///根据图片得到对应的二进制编码
        guard let imageData = self.pngData() else {
            return nil
        }
        ///根据二进制编码得到对应的base64字符串
        var base64String = imageData.base64EncodedString(options: (NSData.Base64EncodingOptions(rawValue:0)))
        ///判断是否带有头部base64标识信息
        if headerSign {
            ///根据格式拼接数据头 添加header信息，扩展名信息
            base64String = "data:image/png;base64," + base64String
        }
        return base64String
    }
    
    /// 传入base64的字符串(可以是没有经过修改的转换成的以data开头的，也可以是base64的内容字符串)转换成UIImage
    ///
    /// - Parameter base64String: 图片的base64字符串
    /// - Returns: 对应的图片
    class func base64StringToUIImage(base64String:String)->UIImage? {
        var str = base64String
        
        // 1、判断用户传过来的base64的字符串是否是以data开口的，如果是以data开头的，那么就获取字符串中的base代码，然后在转换
        if str.hasPrefix("data:image") {
            guard let newBase64String = str.components(separatedBy: CharacterSet.init(charactersIn: ",")).last else{
                return nil
            }
            str = newBase64String
        }
        // 2、将处理好的base64String代码转换成NSData
        guard let imgData = Data.init(base64Encoded: str, options: NSData.Base64DecodingOptions()) else {
            return nil
        }
        // 3、将NSData的图片，转换成UIImage
        guard let codeImage = UIImage(data: imgData) else {
            return nil
        }
        return codeImage
    }
    
    /// 图片裁剪为圆形
    func toCircleImage() -> UIImage?{
        let rect = CGRect.init(origin: .zero, size: self.size)
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        //获取图形上下文
        let contentRef = UIGraphicsGetCurrentContext()
        //根据 rect 创建一个椭圆
        contentRef?.addEllipse(in: rect)
        //裁剪
        contentRef?.clip()
        //将原图片画到图形上下文
        self.draw(in: rect)
        //从上下文获取裁剪后的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片裁剪（new传size）
    func circleImageToSzie(size:CGSize) -> UIImage? {
        let rect = CGRect.init(origin: .zero, size: size)
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        //获取图形上下文
        let contentRef = UIGraphicsGetCurrentContext()
        //根据 rect 创建一个椭圆
        contentRef?.addEllipse(in: rect)
        //裁剪
        contentRef?.clip()
        //将原图片画到图形上下文
        self.draw(in: rect)
        //从上下文获取裁剪后的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片高斯模糊（vImage）
    func makeImageGaussianBlurvImage(value:CGFloat) -> UIImage {
        var blurAmount = value
        //高斯模糊参数(0-1)之间，超出范围强行转成1.0
        if(blurAmount < 0.0||blurAmount > 1.0) {
            blurAmount = 1.0
        }
        
        var boxSize = Int(blurAmount * 100)
        boxSize = boxSize - (boxSize % 2) + 1
        
        guard let img = self.cgImage else {return self}
        
        var inBuffer = vImage_Buffer()
        
        var outBuffer = vImage_Buffer()
        
        guard let inProvider = img.dataProvider else {return self}
        
        let inBitmapData = inProvider.data
        inBuffer.width = vImagePixelCount(img.width)
        inBuffer.height = vImagePixelCount(img.height)
        inBuffer.rowBytes = img.bytesPerRow
        inBuffer.data = UnsafeMutableRawPointer(mutating:CFDataGetBytePtr(inBitmapData))
        
        //手动申请内存
        let pixelBuffer = malloc(img.bytesPerRow * img.height)
        outBuffer.width = vImagePixelCount(img.width)
        outBuffer.height = vImagePixelCount(img.height)
        outBuffer.rowBytes = img.bytesPerRow
        outBuffer.data = pixelBuffer
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer,nil,vImagePixelCount(0),vImagePixelCount(0),
                                               UInt32(boxSize),UInt32(boxSize),nil,vImage_Flags(kvImageEdgeExtend))
        
        if (kvImageNoError != error) {
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer,nil,vImagePixelCount(0),vImagePixelCount(0),
                                               UInt32(boxSize),UInt32(boxSize),nil,vImage_Flags(kvImageEdgeExtend))
            if (kvImageNoError != error) {
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                                   &outBuffer,nil,vImagePixelCount(0),vImagePixelCount(0),
                                                   UInt32(boxSize),UInt32(boxSize),nil,vImage_Flags(kvImageEdgeExtend))
            }
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let ctx = CGContext(data: outBuffer.data,
                            width: Int(outBuffer.width),
                            height: Int(outBuffer.height),
                            bitsPerComponent: 8,
                            bytesPerRow: outBuffer.rowBytes,
                            space: colorSpace,
                            bitmapInfo: self.cgImage?.bitmapInfo.rawValue ?? 0)
        
        if let ctx1 = ctx {
            let imageRef = ctx1.makeImage()
            if let imageRef1 = imageRef {
                //手动申请内存
                free(pixelBuffer)
                
                return UIImage(cgImage: imageRef1)
            }
        }
        
        //手动申请内存
        free(pixelBuffer)
        
        return self
    }
    
    class func scaleToSize(img: UIImage, newsize: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(newsize)
        img.draw(in: CGRect(x: 0, y: 0, width: newsize.width, height: newsize.height))
        let scaledImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage();
        UIGraphicsEndImageContext()
        return scaledImage;
    }
    
    ///给图片添加水印
    ///originImage原图
    ///tagImage水印图片
    ///tagRect水印图片frame
    class func addWatarTagWith(originImage: UIImage, tagImage: UIImage = UIImage.init(named: "yinyueka_water_tag")!, tagRect: CGRect, tagText: String) -> UIImage {
        //1.获取图片
        //2.开启上下文
        UIGraphicsBeginImageContextWithOptions(originImage.size, false, 1.0)
        let contentRef = UIGraphicsGetCurrentContext()
        //将原图片画到图形上下文
        contentRef?.addRect(CGRect.init(x: 0, y: 0, width: originImage.size.width, height: originImage.size.height))
        //3.绘制背景图片
        originImage.draw(in: CGRect.init(x: 0, y: 0, width: originImage.size.width, height: originImage.size.height))
        
        let scale: CGFloat = (originImage.size.width / YUXISCREEN_WIDTH) / 2
        //绘制水印图片到当前上下文
        tagImage.draw(in: CGRect.init(x: originImage.size.width - ((tagRect.width + WIDTH_SCALE(20)) * scale), y: originImage.size.height - ((tagRect.height + WIDTH_SCALE(10)) * scale), width: tagRect.width * scale, height: tagRect.height * scale))
        
        let text = NSString.init(string: tagText)
        text.draw(in: CGRect.init(x: originImage.size.width - (WIDTH_SCALE(108) * scale), y: originImage.size.height - (WIDTH_SCALE(31) * scale), width: WIDTH_SCALE(350) * scale, height: WIDTH_SCALE(20) * scale), withAttributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: WIDTH_SCALE(14) * scale)])
        
        //4.从上下文中获取新图片
        let resultImg = UIGraphicsGetImageFromCurrentImageContext()
        //5.关闭图形上下文
        UIGraphicsEndImageContext()
        //返回图片
        if let newImage = resultImg {
            return newImage
        } else {
            return originImage
        }
    }
    
    //RTL布局
    func hts_imageFlippedForRightToLeftLayoutDirection() -> UIImage{
        /*
        if SAppLanSettings.shareInstance.isRTL {
            return UIImage.init(cgImage: self.cgImage!, scale: self.scale, orientation: .upMirrored)
        }
        */
        return self;
    }
}
