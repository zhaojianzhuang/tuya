//
//  Dot.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class Dot: Vertex {
    
    //    init
    override init(location: CGPoint) {
        super.init(location: location)
    }
    
    //    draw
    override func draw(context: CGContext) -> Void{
        guard let color = color else {return}
        context.setFillColor(color.cgColor)
        
        let frame = CGRect(x: location.x - 2.0 / size,
                           y: location.y - size / 2.0 ,
                           width: size,
                           height: size)
        context.fillEllipse(in: frame)
        
    }
    
    //    visitor
    override func accept(visitor: MarkVisitor) {
        visitor.visit(dot: self)
    }
    
    //    copy
    override func copy(with zone: NSZone?) -> Any {
        let dot = Dot(location: location)
        dot.size = size
        dot.color = color
        return dot
    }
    
    //    equal
    override func equal(other mark: Mark) -> Bool {
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
    
    //    encode
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(color, forKey: CODE_COLOR_KEY)
        aCoder.encode(Float(size), forKey: CODE_SIZE_KEY)
    }
    //    decode
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        size = CGFloat(aDecoder.decodeFloat(forKey: CODE_SIZE_KEY))
        color = aDecoder.decodeObject(forKey: CODE_COLOR_KEY) as? UIColor
    }
}






