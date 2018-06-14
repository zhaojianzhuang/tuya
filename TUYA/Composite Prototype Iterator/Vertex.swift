//
//  Vertex.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit
class Vertex:NSObject, Mark {
    
    var color: UIColor?
    var size: CGFloat=5.0
    var location: CGPoint=CGPoint.zero
    var count: NSInteger=1
    var lastChild: Mark?
    //    init
    init(location:CGPoint) {
        self.location = location
        super.init()
    }
    //    visitor
    func accept(visitor: MarkVisitor) {
        visitor.visit(vertex: self)
    }
    
    //    equal
    func equal(other mark: Mark) -> Bool {
        if color != mark.color {
            return false
        }
        if size != mark.size {
            return false
        }
        if location != mark.location {
            return false
        }
        return true
    }
    
    //    draw
    func draw(context: CGContext) -> Void  {
        context.addLine(to: location)
    }
    
    //    copy delegate
    func copy(with zone: NSZone? = nil) -> Any {
        return Vertex(location: location)
    }
    
    //    self delegate copy
    func copy() -> Any? {
        return self.copy(with: nil)
    }
    
    //    encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(location, forKey: CODE_LOCATION_KEY)
    }
    //    decode
    required init?(coder aDecoder: NSCoder) {
        location = aDecoder.decodeCGPoint(forKey: CODE_LOCATION_KEY)
        super.init()
    }
    //
    func add(mark: Mark) {}
    func remove(mark: Mark) {}
    func childMark(index: NSInteger) -> Mark? {return nil}
    func enumerator(block: (Mark, inout Bool) -> Void) -> Void{}
    func enumerator() -> NSEnumerator? {
        return nil
    }
}


