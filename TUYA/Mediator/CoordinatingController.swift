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

//适配action
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
    
    func present(viewController:UIViewController, animated:Bool, completion:(()->Void)?) -> Void {
            activeViewController_ = viewController
            canvasViewController_.present(viewController, animated: true, completion: completion)
    }
    
    
    func set(activeViewController:UIViewController) -> Void {
        activeViewController_ = activeViewController
    }
//    控制跳转的逻辑
    @objc func requestChange(button:CommandButtonProtocol) -> Void {
        button.command?.execute()
    }
    
}



