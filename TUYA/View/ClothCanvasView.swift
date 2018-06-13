//
//  ClothCanvasView.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class ClothCanvasView: CanvasView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage(named: "background_texture")!
        let color = UIColor(patternImage: image)
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
