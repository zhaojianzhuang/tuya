//
//  RedoCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//  a protocol for redo command
@objc protocol RedoCommandDelegate  {
    
    //    notification delegate undo
    func redo(command:Command) -> Void
    
}
class RedoCommand: NSObject, Command {
    
    weak var delegate:RedoCommandDelegate?
    
    var userinfo: [String : Any]?
    
    init(delegate:RedoCommandDelegate?) {
        self.delegate = delegate
        super.init()
    }
    
    func execute() -> Void {
        delegate?.redo(command: self)
    }
    
    func undo() -> Void {
        
    }
}
