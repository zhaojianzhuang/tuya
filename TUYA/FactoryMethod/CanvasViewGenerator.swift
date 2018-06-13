//
//  CanvasViewGenerator.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit


enum CanvasViewType {
    case cloth, paper
}
class CanvasViewGenerator: NSObject {
    
    class func create(frame:CGRect, type:CanvasViewType) -> CanvasView{
        switch type {
        case .cloth:
            return ClothCanvasView(frame: frame)
        case .paper:
            return PaperCanvasView(frame: frame)
        }
    }
}
