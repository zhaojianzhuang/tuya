//
//  Mark.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import Foundation
import UIKit

// dot -> a vertex
// stroke -> many  vertex
// stroke -> many stroke
// the base data protocol
protocol Mark: NSCoding, NSCopying {
    var color:UIColor? {set get}  // stroke's color and dot's color
    
    var size:CGFloat {set get}    // the size for stroke breadth and dot's diameter
    
    var location:CGPoint { get}   // current site
    
    var count:NSInteger {get}     // all count
    
    var lastChild:Mark? {get}     // the alst node
    
    ///    copy
    func copy() -> Any?
    
    ///    add a mark that stroke can use
    ///    vertex and dot can not
    func add(mark:Mark) -> Void
    
    ///    add a mark that stroke can use
    ///    vertex and dot can not
    func remove(mark:Mark) -> Void
    
    ///    the index of mark in the node
    ///    like top only can stroke can use
    func childMark(index:NSInteger) -> Mark?
    
    ///    the data draw
    func draw(context:CGContext) -> Void
    
    ///   mark1 == mark2
    func equal(other mark:Mark) -> Bool
    
    ///    output a iteration for traverse
    func enumerator() -> NSEnumerator?
    
    ///    traverse with lbock
    func enumerator(block:(( _ mark:Mark, _ stop:inout Bool)->Void))-> Void
    
    ///    accept outside visit the data
    ///    visitor is MarkVisitor that provide four fuction to visit every kind mark
    func accept(visitor:MarkVisitor) -> Void
}





