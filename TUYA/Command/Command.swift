//
//  Command.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

// the api for commonality command
@objc protocol Command {
    
    ///  command extension property
    var userinfo:[String:Any]? {get set}
    
    ///  use this to execute this command
    func execute() -> Void
    
    ///  use this to undo this command if can undo
    func undo() -> Void
    
}

