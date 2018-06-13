//
//  ScribbleMemento.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit



class ScribbleMemento: NSObject {
//    whether complete
    open var hasCompleteSnapshot:Bool=false
//    interview mark and this is readonly
    open var mark:Mark {
        get{
            return mark_
        }
    }
//    saved mark
    private let mark_:Mark
    
//    init
    init(_ mark:Mark) {
        mark_ = mark
        super.init()
    }
    
    convenience init (data:Data) throws {
        let markOption = NSKeyedUnarchiver.unarchiveObject(with: data) as? Mark
        
        guard let mark = markOption else {
            throw ScribbleError.notMarkWithData
        }
        self.init(mark)
    }
    
//MARK:- interface
    
//    if you give a data that can not unarchive as mark that will throw a wrongDataType error
   class func memento(data:Data) throws -> ScribbleMemento {
        let dataObject = NSKeyedUnarchiver.unarchiveObject(with: data)
        guard let mark = dataObject as? Mark else {
            throw ScribbleError.wrongDataError
        }
        return ScribbleMemento(mark)
    }
    
    func data() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: mark_)
    }
    
}


