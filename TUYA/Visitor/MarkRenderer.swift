//
//  MarkRenderer.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//   use this to visit mark's data and draw it when visit it
class MarkRenderer: NSObject, MarkVisitor {
    ///    if it's true move to point and else add line to
    ///    use this to guarantee a stroke first move to line and can only move to once
    fileprivate var shouldMoveContextToDot_ = true
    
    /// context for draw
    fileprivate let context_:CGContext
    
    init(context:CGContext) {
        context_ = context
        super.init()
    }
    ///   base visit
    func visit(mark: Mark) {
        print("default visit")
        mark.draw(context: context_)
    }
    
    ///   draw dot
    ///   a dot is finger touch for center of a circle location
    ///   a half of size for  radius
    func visit(dot: Dot) {
        let color = (dot.color != nil) ? dot.color! : UIColor.black
        context_.setFillColor(color.cgColor)
        context_.setStrokeColor(color.cgColor)
        let location = dot.location
        let size:CGFloat = dot.size
        let frame = CGRect(x: location.x - size / 2.0,
                           y: location.y - size / 2.0 ,
                           width: size,
                           height: size)
        context_.fillEllipse(in: frame)
    }
    
    ///   render the stroke
    func visit(stroke: Stroke) {
        let color = (stroke.color != nil) ? stroke.color! : UIColor.black
        context_.setStrokeColor(color.cgColor)
        context_.setLineWidth(stroke.size)
        context_.setLineCap(CGLineCap.round)
        context_.strokePath()
        shouldMoveContextToDot_ = true
    }
    
    ///   draw point with vertex
    func visit(vertex: Vertex) {
        if shouldMoveContextToDot_ {
            context_.move(to: vertex.location)
            shouldMoveContextToDot_ = false
            
        } else {
            context_.addLine(to: vertex.location)
        }
        
    }
}




