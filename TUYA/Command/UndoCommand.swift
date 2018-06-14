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
//    record scribble
    var scribble:Scribble?
    
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
//MARK:- private
extension UndoCommand {
    @objc fileprivate func revocation(obj:NSObject) -> Void {
        guard let mark = obj as? Mark else {return}
        scribble?.remove(mark: mark)
//        scribble?.revocationAgainstDelegate?.revocationAgainst(scribble: scribble, manager: manager, mark: mark)
    }
}
//MARK:- ScribbleRevocationDelegate
extension UndoCommand:ScribbleRevocationDelegate {
    func revocation(scribble: Scribble?, manager: UndoManager, mark: Mark) {
        if self.scribble == nil {
            self.scribble = scribble
        }

        manager.registerUndo(withTarget: self, selector: #selector(revocation(obj:)), object: mark)
    }
}


