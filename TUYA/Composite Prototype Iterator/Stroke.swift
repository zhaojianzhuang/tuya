//
//  File.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//
import UIKit




class Stroke:NSObject, Mark {
    
    //    property
    var children_ = [Mark]()
    var color: UIColor?
    var size: CGFloat = 0.0
    
    var location: CGPoint {
        return count == 0 ? CGPoint.zero : children_.first!.location
    }
    var count: NSInteger  {
        return children_.count
    }
    var lastChild: Mark?  {
        return count == 0 ? nil : children_.last
    }
    
    //    init
    override init() {
        super.init()
    }
    //    visitor
    func accept(visitor: MarkVisitor) -> Void {
        
        for mark in children_ {
            mark.accept(visitor: visitor)
        }
        visitor.visit(stroke: self)
    }
    //    enumator block
    func enumerator(block: (Mark, inout Bool) -> Void) {
        var stop = false
        guard let enu = self.enumerator() else { return }
        for mark in enu {
            block(mark as! Mark, &stop)
            if stop {
                break
            }
        }
    }
    //     enumerator
    func enumerator() -> NSEnumerator? {
        return MarkEnumerator(mark: self)
    }
    //  add mark
    func add(mark: Mark) {
        children_.append(mark)
    }
    
    //    delete mark
    func remove(mark: Mark) {
        let indexContain = children_.index(where: {$0.equal(other:mark)})
        guard let index = indexContain else {
            print("删除失败")
            return
        }
        children_.remove(at: index)
    }
    
    //    get mark with index
    func childMark(index: NSInteger) -> Mark? {
        return children_[index]
    }
    
    //    draw
    func draw(context: CGContext) ->Void {
        guard let color = color else {return}
        context.move(to: location)
        for mark in children_ {
            mark.draw(context: context)
        }
        context.setLineWidth(size)
        context.setLineCap(CGLineCap.round)
        context.setFillColor(color.cgColor)
        context.strokePath()
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
        for mark in children_ {
            if !equal(other: mark) {
                return false
            }
        }
        return true
    }
    
    //    copy
    func copy() -> Any? {
        return self.copy(with: nil)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let stroke = Stroke()
        stroke.size = size
        stroke.color = color
        stroke.children_ = children_.map({$0.copy()}) as! [Mark]
        return stroke
    }
    
    //  encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(children_, forKey: CODE_MARK_KEY)
        aCoder.encode(Float(size), forKey: CODE_SIZE_KEY)
        aCoder.encode(color, forKey: CODE_COLOR_KEY)
    }
    
    //    decode
    required init?(coder aDecoder: NSCoder) {
        color = aDecoder.decodeObject(forKey: CODE_COLOR_KEY) as? UIColor
        size = CGFloat(aDecoder.decodeFloat(forKey: CODE_SIZE_KEY))
        children_ = aDecoder.decodeObject(forKey: CODE_MARK_KEY) as! [Mark]
        super.init()
    }
    
}







