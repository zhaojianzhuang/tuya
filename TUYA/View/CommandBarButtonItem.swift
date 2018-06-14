//
//  CommandBarButtonItem.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit
//为UIBarButtonItem扩充一个command的属性
class CommandBarButtonItem: UIBarButtonItem, CommandButtonProtocol {
    open var command:Command?
    init(command:Command?, image: UIImage?, style: UIBarButtonItemStyle, target: Any?, action: Selector?, title:String?) {
        super.init()
        self.image = image
        self.style = style
        self.target = target as AnyObject
        self.action = action
        self.title = title
        self.command = command
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

