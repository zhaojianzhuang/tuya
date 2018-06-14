//
//  CommandButtonProtocol.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//extension button action that button must observe CommandButtonProtocol
//use comamnd.execute() handle action 
@objc protocol CommandButtonProtocol:NSObjectProtocol {
    var command:Command? {set get}
}

