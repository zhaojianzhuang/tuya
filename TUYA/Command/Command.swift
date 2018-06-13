//
//  Command.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit
protocol Command {
    var userinfo:[String:Any]? {get set}
    func execute() -> Void
    func undo() -> Void
}
