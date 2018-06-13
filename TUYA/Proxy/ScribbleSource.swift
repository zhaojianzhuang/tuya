//
//  ScribbleSource.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/12.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit
protocol ScribbleSource {
    func scribble() throws -> Scribble 
}
