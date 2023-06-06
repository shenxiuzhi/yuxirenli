//
//  SImagePickerObject.swift
//  Sheng
//
//  Created by DS on 2017/8/15.
//  Copyright © 2017年 mac. All rights reserved.
//


import UIKit
import Photos

/// UIImagePickerController 管理对象
class SImagePickerObject: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    /// 单例
    class var shared: SImagePickerObject {
        struct instance {
            static let _instance:SImagePickerObject = SImagePickerObject()
        }
        return instance._instance
    }
    
    /// 选择原始图片完成回调
    var finishPickingBlock:((_ image:UIImage,_ imagePath:String,_ imageFormat:String)->())?
    
    /// 选择原始图片编辑完成回调
    var editPickingBlock:((_ image:UIImage,_ imagePath:String,_ imageFormat:String)->())?
    
    /// 选择原始图片编辑并压缩完成回调
    var editCompressPickingBlock:((_ image:UIImage,_ imagePath:String,_ imageFormat:String)->())?
    
    ///当不可编辑时为了展示图片，暂存图片的信息
    var currentImageinfo: [String : Any]!
    var currentPickerVC: UIImagePickerController!
    
    /// 显示相机
    func showCamera(allowEdit:Bool) {
        UIViewController.getCurrentViewCtrl().view.makeToastActivity(.center)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if authStatus == .denied || authStatus == .restricted{  //受限制或被拒绝
                UIViewController.bottomToast(message: "相机权限未开启")
                UIViewController.getCurrentViewCtrl().view.hideToastActivity()
                return
            }
            //打开相机
            let imagePickerCtrl = UIImagePickerController.init()
            imagePickerCtrl.delegate = self
            imagePickerCtrl.sourceType = .camera
            imagePickerCtrl.allowsEditing = allowEdit
            UIViewController.getCurrentViewCtrl().present(imagePickerCtrl, animated: true, completion: nil)
            UIViewController.getCurrentViewCtrl().view.hideToastActivity()
        }else{
            UIViewController.getCurrentViewCtrl().view.hideToastActivity()
            UIViewController.bottomToast(message: "该设备不支持照相机")
        }
    }
    
    
    /// 显示图库
    func showPhotoLibrary(allowEdit:Bool) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let authStatus = PHPhotoLibrary.authorizationStatus()
            if authStatus == .notDetermined{    //未设置
                PHPhotoLibrary.requestAuthorization({ (_) in
                    self.showPhotoLibrary(allowEdit: allowEdit)
                })
                return
            }else if authStatus == .denied || authStatus == .restricted{  //受限制或被拒绝
                DispatchQueue.main.async {
                    UIViewController.bottomToast(message: "相册权限未开启")
                }
                return
            }
            DispatchQueue.main.async {
                //打开图库
                let imagePickerC = UIImagePickerController.init()
                imagePickerC.delegate = self
                imagePickerC.sourceType = .photoLibrary
                imagePickerC.allowsEditing = allowEdit
                imagePickerC.modalPresentationStyle = .custom
    //            imagePickerC.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePickerC.sourceType)! //设置显示所有类型
                UIViewController.getCurrentViewCtrl().present(imagePickerC, animated: true, completion: nil)
            }
            
        }else{
            UIViewController.bottomToast(message: "该设备不支持相册")
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        guard let mediaType = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaType)] as? String else {return} //选择的媒体类型
        if picker.allowsEditing == true {  //选择并编辑图片
            if let block = self.editPickingBlock {
                if mediaType == "public.image" {
                    var pathStr: String = ""    //图片路径
                    var imgFormat: String = ""   //图片格式
                    guard let ima = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage else {return}
                    let imaData: Data?
                    if ima.pngData() == nil{
                        imaData = ima.jpegData(compressionQuality: 1)
                        imgFormat = "jpg"
                    }else{
                        imaData = ima.pngData()
                        imgFormat = "png"
                    }
                    pathStr = "/headPhoto." + imgFormat
                    if FileManager.default.createFile(atPath: YUXIPATH_OF_CACHE.appending(pathStr), contents: imaData, attributes: nil){
                        picker.dismiss(animated: true, completion: {
                            UIViewController.getCurrentViewCtrl().view.makeToastActivity(.center)
                            block(ima, pathStr, imgFormat)
                        })
                    }
                }else if mediaType == "public.movie" {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
            }else if let block = self.editCompressPickingBlock { //压缩
                if mediaType == "public.image" {
                    var pathStr: String = ""    //图片路径
                    var imgFormat: String = ""   //图片格式
                    guard let editImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage else {return}
                    let ima = editImage.compressToScaleSize(toWidth: 640)
                    let imaData: Data?
                    if ima.jpegData(compressionQuality: 0.85) == nil{
                        imaData = ima.pngData()
                        imgFormat = "png"
                    }else{
                        imaData = ima.jpegData(compressionQuality: 0.85)
                        imgFormat = "jpg"
                    }
                    pathStr = "/headPhoto." + imgFormat
                    if FileManager.default.createFile(atPath: YUXIPATH_OF_CACHE.appending(pathStr), contents: imaData, attributes: nil){
                        picker.dismiss(animated: true, completion: {
                            UIViewController.getCurrentViewCtrl().view.makeToastActivity(.center)
                            block(ima, pathStr, imgFormat)
                        })
                    }
                }else if mediaType == "public.movie" {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
            }
        }else { //选择图片
            
            if mediaType == "public.image" {
                guard let selectImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {return}
                currentImageinfo = info
                currentPickerVC = picker
                self.showDisplayPhotoViewWith(selImage: selectImage)
                
            } else if mediaType == "public.movie" {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            ///////////////////////
            /*
            if let block = self.finishPickingBlock{
                if mediaType == "public.image" {
                    guard let selImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
                    var imaData: Data?
                    var pathStr: String = ""        //图片路径
                    var imgFormat: String = ""      //图片格式
                    if UIImagePNGRepresentation(selImage) == nil{
                        imaData = UIImageJPEGRepresentation(COSModel.fixOrientation(selImage), 1)
                        imgFormat = "jpg"
                    }else{
                        imaData = UIImagePNGRepresentation(COSModel.fixOrientation(selImage))
                        imgFormat = "png"
                    }
                    pathStr = "/PrivateletterPhoto." + imgFormat
                    if FileManager.default.createFile(atPath: PATH_OF_CACHE.appending(pathStr), contents: imaData, attributes: nil){
                        picker.dismiss(animated: true) {
                            UIViewController.getCurrentViewCtrl().view.makeToastActivity(.center)
                            block(selImage,pathStr,imgFormat)
                        }
                    }
                    
                    
                    
                }else if mediaType == "public.movie" {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
            }
            */
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if picker.sourceType == .camera{
            Dprint("取消了拍照")
        }else{
            Dprint("取消了选择")
        }
    }


    //添加展示选中图片的视图
    func showDisplayPhotoViewWith(selImage: UIImage) {
        let controller = UIViewController.getCurrentViewCtrl()
        let imageShowV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: YUXISCREEN_HEIGHT))
        imageShowV.backgroundColor = .white
        
        let actionView = UIView.init(frame: CGRect.init(x: 0, y: YUXIISHairHead ? (YUXISCREEN_HEIGHT - CGFloat(80 * YUXIIPONE_SCALE)) : (YUXISCREEN_HEIGHT - CGFloat(50 * YUXIIPONE_SCALE)), width: YUXISCREEN_HEIGHT, height: YUXIISHairHead ? CGFloat(80 * YUXIIPONE_SCALE) : CGFloat(50 * YUXIIPONE_SCALE)))
        actionView.backgroundColor = YUXICOLOR(h: 0x000000, alpha: 0.65)
        
        let cancelBtn = UIButton.init(type: .custom)
        cancelBtn.frame = CGRect.init(x: 0, y: 0, width: CGFloat(100 * YUXIIPONE_SCALE), height: CGFloat(50 * YUXIIPONE_SCALE))
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClickAction), for: .touchUpInside)
        actionView.addSubview(cancelBtn)
        
        let confirmBtn = UIButton.init(type: .custom)
        confirmBtn.frame = CGRect.init(x: (YUXISCREEN_WIDTH - CGFloat(100 * YUXIIPONE_SCALE)), y: 0, width: CGFloat(100 * YUXIIPONE_SCALE), height: CGFloat(50 * YUXIIPONE_SCALE))
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.setTitleColor(.white, for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClickAction), for: .touchUpInside)
        actionView.addSubview(confirmBtn)
        
        let imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: YUXISCREEN_WIDTH, height: YUXISCREEN_HEIGHT))
        imageV.contentMode = .scaleAspectFit
        imageV.image = selImage
        imageV.isUserInteractionEnabled = true
        imageShowV.addSubview(imageV)
        
        imageShowV.addSubview(actionView)
        controller.view.addSubview(imageShowV)
//        imageV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(animationHiddenNavBar)))
//        animationHiddenNavBar()
    }
    
    //点击取消操作
    @objc private func cancelBtnClickAction() {
        currentPickerVC.dismiss(animated: true, completion: nil)
        return
    }
    
    //点击确认操作
    @objc private func confirmBtnClickAction() {
        if let block = self.finishPickingBlock{
            guard let selImage = currentImageinfo[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {return}
//            var imaData: Data?
            var pathStr: String = ""        //图片路径
            var imgFormat: String = ""      //图片格式
            if selImage.pngData() == nil{
//                imaData = COSModel.fixOrientation(selImage).jpegData(compressionQuality: 1)
                imgFormat = "jpg"
            }else{
//                imaData = COSModel.fixOrientation(selImage).pngData()
                imgFormat = "png"
            }
            pathStr = "/PrivateletterPhoto." + imgFormat
//            if FileManager.default.createFile(atPath: YUXIPATH_OF_CACHE.appending(pathStr), contents: imaData, attributes: nil){
                currentPickerVC.dismiss(animated: true) {
                    UIViewController.getCurrentViewCtrl().view.makeToastActivity(.center)
                    block(selImage,pathStr,imgFormat)
                }
//            }
        }
    }
    
    //显示隐藏导航栏
    @objc private func animationHiddenNavBar() {
        if currentPickerVC != nil {
            currentPickerVC.navigationBar.alpha = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.currentPickerVC.navigationBar.alpha = 0.0
                })
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
