//
//  Scribble.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit
//   Scribble delegate for revocation last add
protocol ScribbleRevocationDelegate:NSObjectProtocol {
    func revocation(scribble:Scribble?, manager:UndoManager, mark:Mark) -> Void
}

//   Scribble delegate for against last revocation
protocol ScribbleRevocationAgainstDelegate:NSObjectProtocol {
    func revocationAgainst(scribble:Scribble?, manager:UndoManager, mark:Mark) -> Void
}

class Scribble: NSObject {
    
    ///  revocation manager
    let manager:UndoManager = UndoManager()
    
    ///  revocation delegate
    weak var revocationDelegate:ScribbleRevocationDelegate?
    ///  against revocation delegate
    weak var revocationAgainstDelegate:ScribbleRevocationAgainstDelegate?
    
    
    fileprivate var parentMark_:Mark         // mark's root node
    fileprivate var incrementalMark_:Mark?   //use to sign incremental mark
    
    //    use to handle observer
    //    visit is parentMark_
    @objc dynamic var mark:NSObject {
        get {
            return parentMark_ as! NSObject  // in swift observer must obvious be NSObject
        }
    }
    
    open var scribbleMemento:ScribbleMemento? {
        get {
            return try? scribbleMemento(hasCompleteSnapshot: true)
        }
    }
    
    //    MARK:- init
    override init() {
        parentMark_ = Stroke()
        super.init()
    }
    
    init(memento:ScribbleMemento, manager:UndoManager?) {
        if memento.hasCompleteSnapshot {
            parentMark_ = memento.mark
        } else {
            parentMark_ = Stroke()
        }
        super.init()
        if !memento.hasCompleteSnapshot {
            attachState(from: memento)
        }
    }
    
    //    clear all mark
    func clear() -> Void {
        willChangeValue(forKey: "mark")
        let mark = parentMark_.copy() as! Mark
        parentMark_.removeAll()
        revocationAgainstDelegate?.revocationAgainst(scribble: self, manager: manager, mark: mark)
        incrementalMark_ = parentMark_
        didChangeValue(forKey: "mark")
    }
    
    //    open a local save
    func attachState(from memento:ScribbleMemento) -> Void {
        add(amark: memento.mark, shouldAddToPreviousMark: false)
    }
    //    add a mark
    //    amark : mark
    //    shouldAddToPreviousMark : add to a previous mark
    func add(amark:Mark, shouldAddToPreviousMark:Bool=false) -> Void {
        
        willChangeValue(forKey: "mark")
        if shouldAddToPreviousMark {
            parentMark_.lastChild?.add(mark: amark)
        } else {
            parentMark_.add(mark: amark)
            incrementalMark_ = amark
            //   this handle revocation
            revocationDelegate?.revocation(scribble: self, manager: manager, mark: amark)
        }
        didChangeValue(forKey: "mark")
    }
    
    func add(marks:[Mark]) -> Void {
        for mark in marks {
            parentMark_.add(mark: mark)
        }
    }
    
    //    remvoe a mark
    func remove(mark:Mark) -> Void {
        if mark.equal(other: parentMark_) {
            print("remove mark error")
            return
        }
        willChangeValue(forKey: "mark")
        parentMark_.remove(mark: mark)
        //   this handle against revocation
        revocationAgainstDelegate?.revocationAgainst(scribble: self, manager: manager, mark: mark)
        didChangeValue(forKey: "mark")
    }
    
    //
    func scribbleMemento(hasCompleteSnapshot:Bool) throws -> ScribbleMemento {
        guard var mementoMark = incrementalMark_ else {
            throw ScribbleError.incrementalEmptyError
        }
        if hasCompleteSnapshot {
            mementoMark = parentMark_
        }
        return ScribbleMemento(mementoMark)
    }
    
}









