//
//  CanvasView.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    var mark:Mark? //绘制的数据
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    绘制
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let markRender = MarkRenderer(context: context)
        mark?.accept(visitor: markRender)
    }
    
}

