//
//  PaletteThumbnailBaseViewController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//基类, 缩略图跟颜色图的, 他们都有点击完成的逻辑
class PaletteThumbnailBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        doneInit()
    }
    
    func doneInit() -> Void {
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: CoordinatingController.default, action:#selector(CoordinatingController.requestChange(object:)) )
        item.tag = ButtonTag.kButtonTagDone.rawValue
        self.navigationItem.rightBarButtonItem = item
    }

}
