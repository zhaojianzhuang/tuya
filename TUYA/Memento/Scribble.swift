//
//  Scribble.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class Scribble: NSObject {
    
    fileprivate var parentMark_:Mark
    fileprivate var incrementalMark_:Mark?
    
    @objc dynamic var mark:NSObject {
        get {
            return parentMark_ as! NSObject
        }
    }
    
    open var scribbleMemento:ScribbleMemento? {
        get {
            return try? scribbleMemento(hasCompleteSnapshot: true)
        }
    }
    
    override init() {
        parentMark_ = Stroke()
        super.init()
    }
    
    init(memento:ScribbleMemento) {
        
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
    
    func attachState(from memento:ScribbleMemento) -> Void {
        add(amark: memento.mark, shouldAddToPreviousMark: false)
    }
    
    func add(amark:Mark, shouldAddToPreviousMark:Bool) -> Void {
        
        willChangeValue(forKey: "mark")
        if shouldAddToPreviousMark {
            parentMark_.lastChild?.add(mark: amark)
        } else {
            parentMark_.add(mark: amark)
            incrementalMark_ = amark
        }
        didChangeValue(forKey: "mark")
    }
    
    func remove(mark:Mark) -> Void {
        if mark.equal(other: parentMark_) {
            print("remove mark error")
            return
        }
        willChangeValue(forKey: "mark")
        parentMark_.remove(mark: mark)
        guard let equal = incrementalMark_?.equal(other: mark) else {
            return
        }
        if equal {
            incrementalMark_ = nil
        }
        didChangeValue(forKey: "mark")
    }
    
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

