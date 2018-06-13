//
//  MarkVisitor.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

protocol MarkVisitor {
    func visit(mark:Mark) -> Void
    func visit(dot:Dot) -> Void
    func visit(stroke:Stroke) -> Void
    func visit(vertex:Vertex) ->Void    
}
