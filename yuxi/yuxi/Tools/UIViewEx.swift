//
//  UIViewEx.swift
//  Sheng
//
//  Created by DS on 2018/1/4.
//  Copyright © 2018年 First Cloud. All rights reserved.
//

import UIKit
import Foundation

// MARK: - UIView类别
extension UIView{
    
    /// 画虚线
    ///
    /// - Parameter color: 线的颜色
    func makeDottedLine(color:UIColor) {
        self.layer.masksToBounds = true
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x:self.frame.width/2.0, y:self.frame.height/2.0)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        shapeLayer.lineDashPattern = [NSNumber(value: 5), NSNumber(value: 2)]
        self.layer.addSublayer(shapeLayer)
        
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: self.frame.height/2.0))
        path.addLine(to: CGPoint(x: 414, y: self.frame.height/2.0))
        shapeLayer.path = path
    }
    
    /// 翻转动画
    func makeOglFlipAnimation(subtype:String = convertFromCATransitionSubtype(CATransitionSubtype.fromRight), duration:Double = 0.25) {
        let ani = CATransition.init()
        ani.type = convertToCATransitionType("oglFlip") //设置动画类型
        ani.subtype = convertToOptionalCATransitionSubtype(subtype)    //设置动画的方向(默认kCATransitionFromRight)
        ani.duration = duration  //设置动画时长(默认0.25)
        self.layer.add(ani, forKey: "oglFlipAnimation")
    }
    
    /// 翻转动画
    func makeOglFlipAnimationFromBottom(subtype:String = convertFromCATransitionSubtype(CATransitionSubtype.fromBottom), duration:Double = 0.25) {
        let ani = CATransition.init()
        ani.type = convertToCATransitionType("oglFlip") //设置动画类型
        ani.subtype = convertToOptionalCATransitionSubtype(subtype)    //设置动画的方向(默认kCATransitionFromRight)
        ani.duration = duration  //设置动画时长(默认0.25)
        self.layer.add(ani, forKey: "oglFlipAnimation")
    }
    
    /// View绘制成Image
    ///
    /// - Returns: 绘制成的Image
    func makeSelfToImage() -> UIImage? {
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        //获取图形上下文
        guard let imgContext = UIGraphicsGetCurrentContext() else {return nil}
        self.layer.render(in: imgContext)
        //从上下文获取裁剪后的图片
        let viewImg = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext();
        return viewImg;
    }
    
    /// 添加毛玻璃视图(其下方都会有模糊效果)
    ///
    /// - Parameter frame: frame
    func addBlurEffectView(frame:CGRect) {
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .dark)
        //接着创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView.frame = frame
        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
        self.addSubview(blurView)
    }
    
    
    /// 添加渐变层
    ///
    /// - Parameters:
    ///   - colors: 渐变色值
    ///   - locations: 颜色所在位置(默认开始结束处)
    ///   - isHor: 是否是横向渐变(默认竖向)
    /// - Returns: 渐变层
    @discardableResult func addGradientLayer(colors: [Any], locations: [NSNumber] = [0.0, 1.0], isHor: Bool = false) -> CAGradientLayer {
        let graLayer = CAGradientLayer()
        graLayer.frame = self.bounds
        graLayer.backgroundColor = UIColor.clear.cgColor
        graLayer.colors = colors //设置渐变色
        graLayer.locations = locations
        if isHor{ //设置横向渐变
            graLayer.startPoint = CGPoint.init(x: 0.0, y: 0.0)  //默认.5,0
            graLayer.endPoint = CGPoint.init(x: 1.0, y: 0.0)  //默认.5,1
        }
        self.layer.insertSublayer(graLayer, at: 0)
        return graLayer
    }
        
    func addGradientLayerWithBounds(colors: [Any], sBounds:CGRect, locations: [NSNumber] = [0.0, 1.0], isHor: Bool = false) -> CAGradientLayer {
        let graLayer = CAGradientLayer()
        graLayer.frame = sBounds
        graLayer.backgroundColor = UIColor.clear.cgColor
        graLayer.colors = colors //设置渐变色
        graLayer.locations = locations
        if isHor{ //设置横向渐变
            graLayer.startPoint = .zero
            graLayer.endPoint = CGPoint.init(x: 1, y: 0)
        }
        self.layer.insertSublayer(graLayer, at: 0)
        return graLayer
    }
    
    
    
    /// 设置视图部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    ///   - rect:  控件bounds
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, rect:CGRect) {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 截取屏幕快照
    /// - Parameters:
    /// paramsV: 需要截取的视图
    func takeScreenPhotoOfFullContent(paramsV:UIView) -> UIImage? {
        let originalFrame = paramsV.frame
        if paramsV.isKind(of: UIScrollView.classForCoder()) {
            let contentV: UIScrollView = paramsV as! UIScrollView
            let originalOffset = contentV.contentOffset
            contentV.frame = CGRect.init(origin: originalFrame.origin, size: contentV.contentSize)
            contentV.contentOffset = .zero
            let backgroundColor = contentV.backgroundColor ?? UIColor.white
            UIGraphicsBeginImageContextWithOptions(contentV.bounds.size, true, 0)
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            context.setFillColor(backgroundColor.cgColor)
            context.setStrokeColor(backgroundColor.cgColor)
            
            contentV.drawHierarchy(in: contentV.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            contentV.frame = originalFrame
            contentV.contentOffset = originalOffset
            return image
            
        } else {
            paramsV.frame = CGRect.init(origin: originalFrame.origin, size: paramsV.frame.size)
            let backgroundColor = paramsV.backgroundColor ?? UIColor.white
            UIGraphicsBeginImageContextWithOptions(paramsV.bounds.size, true, 0)
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            context.setFillColor(backgroundColor.cgColor)
            context.setStrokeColor(backgroundColor.cgColor)
            
            paramsV.drawHierarchy(in: paramsV.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            paramsV.frame = originalFrame
            return image
        }
    }
    
    func removeAllSubviews(){
        synchronized(self.subviews) {
            for view in self.subviews{
                view.removeFromSuperview()
            }
        }
    }
    
    func removeSubview(atIndex index: Int){
        synchronized(self.subviews) {
            guard self.subviews.count > index else{
                return
            }
            self.subviews[index].removeFromSuperview()
        }
    }
    
    private struct AssociatedKeys {
        static var actionModelKey = "actionModelKey"
    }
    
    var actionModel: AnyObject? {
        get{
            guard let t = objc_getAssociatedObject(self,  &AssociatedKeys.actionModelKey) else {
                return nil
            }
            return t as AnyObject
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.actionModelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 位移动画
    ///
    /// - Parameters:
    ///   - fromPoint: 开始位置
    ///   - toPoint: 结束位置
    ///   - duration: 时长
    func positionAnimation(fromPoint:CGPoint, toPoint:CGPoint, duration:Double = 1.0, finishBlock:(()->())?) {
        //使用CABasicAnimation创建基础动画
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.fromValue = fromPoint
        animation.toValue = toPoint
        animation.duration = CFTimeInterval(duration)
        //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
//        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeIn)
        self.layer.add(animation, forKey: "positionAnimation")
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + duration, execute: {
            if let block = finishBlock{
                block()
            }
        })
    }
    
    /// 旋转动画
    ///
    /// - Parameter duration: 旋转一周需要的时长
    /// - Parameter roration: 方向
    /// - Parameter piNum: 1=180度,2= 360度
    func rotateAnimation(duration:Double = 1.0 ,roration:String = "z" , piNum:Double = 2 ) {
        var string = "transform.rotation.z"
        switch roration {
        case "x":
            string =  "transform.rotation.x"
        case "y":
            string =  "transform.rotation.y"
        default:
            string = "transform.rotation.z"
        }
        let animation = CABasicAnimation.init(keyPath: string)//绕着z轴为矢量，进行旋转
        animation.toValue = NSNumber.init(value: piNum*Double.pi)
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: "rotateAnimation")
    }
    
    /*
     /**
     *  旋转动画
     */
     -(void)rotateAnimation{
     CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
     anima.toValue = [NSNumber numberWithFloat:M_PI];
     anima.duration = 1.0f;
     [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
     
     */
    
    ///将当前视图转为UIImage
    func getImage() -> UIImage {
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext(){
            self.layer.render(in: context)
        }
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            return image
        }
        let image = UIImage()
        return image
    }
    
    func setAnchorPoint(anchorPoint: CGPoint){
        let oldFrame = self.frame;
        self.layer.anchorPoint = anchorPoint;
        self.frame = oldFrame;
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionSubtype(_ input: CATransitionSubtype) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
	guard let input = input else { return nil }
	return CATransitionSubtype(rawValue: input)
}
