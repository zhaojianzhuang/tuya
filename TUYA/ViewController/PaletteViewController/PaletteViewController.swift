//
//  PaletteViewController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class PaletteViewController: PaletteThumbnailBaseViewController {
    let colorChangeView = ColorChangeView(frame: CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: 200))
    let sizeChangeView = SizeChangeView(frame: CGRect(x: 0, y: SCREEN_Height / 2, width: SCREEN_WIDTH, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "setting up"
        view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge.bottom
        view.addSubview(colorChangeView)
        view.addSubview(sizeChangeView)
    }
    
}

