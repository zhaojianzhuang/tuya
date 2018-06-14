//
//  MarkVisitor.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

// the protocol for visit the mark data
// that we can use this protocol to visit mark's data and draw it
protocol MarkVisitor {
    
//    visit the base mark
    func visit(mark:Mark) -> Void
    
//    visit dot
    func visit(dot:Dot) -> Void
    
//    visit stroke
    func visit(stroke:Stroke) -> Void
    
//    visit vertex
    func visit(vertex:Vertex) ->Void
    
}
