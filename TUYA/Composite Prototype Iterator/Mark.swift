//
//  Mark.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import Foundation
import UIKit

protocol Mark: NSCoding, NSCopying {
    var color:UIColor? {set get}
    var size:CGFloat {set get}
    var location:CGPoint { get}
    var count:NSInteger {get}
    var lastChild:Mark? {get}
    
    func copy() -> Any?
    func add(mark:Mark) -> Void
    func remove(mark:Mark) -> Void
    func childMark(index:NSInteger) -> Mark?
    func draw(context:CGContext) -> Void 
    func equal(other mark:Mark) -> Bool
    func enumerator() -> NSEnumerator?
    func enumerator(block:(( _ mark:Mark, _ stop:inout Bool)->Void))-> Void
    func accept(visitor:MarkVisitor) -> Void
}

