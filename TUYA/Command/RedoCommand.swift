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
    
    //    record scribble
    var scribble:Scribble?
    
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
//MARK:- private
extension RedoCommand {
    @objc fileprivate func revocationAgainst(obj:NSObject) -> Void {
        guard let mark = obj as? Mark else {return}
        scribble?.add(amark: mark)
    }
}
//MARK:-ScribbleRevocationAgainstDelegate
extension RedoCommand:ScribbleRevocationAgainstDelegate {
    func revocationAgainst(scribble: Scribble?, manager: UndoManager, mark: Mark) {
        if self.scribble == nil {
            self.scribble = scribble
        }
        manager.registerUndo(withTarget: self, selector: #selector(revocationAgainst(obj:)), object: mark)
    }
    
}

