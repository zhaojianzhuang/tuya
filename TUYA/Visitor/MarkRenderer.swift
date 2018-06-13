//
//  MarkRenderer.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class MarkRenderer: NSObject, MarkVisitor {
    
    fileprivate var shouldMoveContextToDot_ = true
    fileprivate let context_:CGContext
    init(context:CGContext) {
        context_ = context
        super.init()
    }
    
    func visit(mark: Mark) {
        print("default visit")
        mark.draw(context: context_)
    }
    
    func visit(dot: Dot) {
//        guard let color = dot.color else {return}
        let color = (dot.color != nil) ? dot.color! : UIColor.black
        context_.setFillColor(color.cgColor)
        context_.setStrokeColor(color.cgColor)
        let location = dot.location
        let size:CGFloat = dot.size
        let frame = CGRect(x: location.x - 2.0 / size,
                           y: location.y - size / 2.0 ,
                           width: size,
                           height: size)
        context_.fillEllipse(in: frame)
    }
    
    func visit(stroke: Stroke) {
//        guard let color = stroke.color else {return}
        let color = (stroke.color != nil) ? stroke.color! : UIColor.black
        context_.setStrokeColor(color.cgColor)
        context_.setLineWidth(stroke.size)
        context_.setLineCap(CGLineCap.round)
        context_.strokePath()
        shouldMoveContextToDot_ = true
    }
    
    func visit(vertex: Vertex) {
        if shouldMoveContextToDot_ {
            context_.move(to: vertex.location)
            shouldMoveContextToDot_ = false

        } else {
            context_.addLine(to: vertex.location)
        }

    }
}

