//
//  CoordinatingController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

enum ButtonTag:Int {
    case kButtonTagDone, // 完成
    kButtonTagOpenPaletteView, // 打开颜色
    kButtonTagOpenThumbnailView // 打开缩略图
}

//适配主页跳转的类
class CoordinatingController: NSObject
{
    static let `default` = CoordinatingController()
    private let canvasViewController_:CanvasViewController
    private var activeViewController_:UIViewController?
    
//    获取主页的那个控制器
    var canvasViewController: CanvasViewController{
        get{
            return canvasViewController_
        }
    }
    
//    获取当前存在的控制器
    var activeViewController:UIViewController {
        get {
            return activeViewController_!
        }
    }
    
    override init() {
        self.canvasViewController_ = CanvasViewController()
        super.init()
    }
    
    func set(activeViewController:UIViewController) -> Void {
        activeViewController_ = activeViewController
    }
//    控制跳转的逻辑
    @objc func requestChange(object:Any) -> Void {
        
        guard let barButton = object as? UIBarButtonItem else {
            canvasViewController_.dismiss(animated: true, completion: nil)
            activeViewController_ = canvasViewController_
            return
        }
        
        switch barButton.tag {
        case ButtonTag.kButtonTagOpenPaletteView.rawValue:
            let palletvc = PaletteViewController()
            activeViewController_ = palletvc
            
            canvasViewController_.present(UINavigationController(rootViewController: palletvc), animated: true, completion: nil)
            break
        case ButtonTag.kButtonTagOpenThumbnailView.rawValue:
            let thumailVC = ThumbnailViewController()
            activeViewController_ = thumailVC
            canvasViewController_.present(UINavigationController(rootViewController: thumailVC), animated: true , completion: nil)
            break
        default:
            canvasViewController_.dismiss(animated: true, completion: nil)
            activeViewController_ = canvasViewController_
            break
        }
        
    }
    
}



