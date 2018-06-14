//
//  UndoCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit


//  a protocol for undo command
@objc protocol UndoCommandDelegate  {
    
    //    notification delegate undo
    func undo(command:Command) -> Void
    
}
class UndoCommand:NSObject, Command {
//
    var userinfo: [String : Any]?
//    delegate
    weak var delegate:UndoCommandDelegate?
    
    init(delegate:UndoCommandDelegate?) {
        self.delegate = delegate
        super.init()
    }
    
    func execute() -> Void {
        delegate?.undo(command: self)
    }
    
    func undo() -> Void {
        
    }
}

