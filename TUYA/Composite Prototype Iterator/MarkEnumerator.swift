//
//  MarkEnumerator.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class MarkEnumerator: NSEnumerator {
    fileprivate let mark_:Mark
    fileprivate var stack_ = [Mark]()
    init(mark:Mark) {
        mark_ = mark
        super.init()
    }
    
    override func nextObject() -> Any? {
       return stack_.popLast()
    }
    
    func traverseAndBuild(mark:Mark) -> Void {
        stack_.append(mark)
        var index = mark.count
        while let childrenMark = mark.childMark(index:index) {
            self.traverseAndBuild(mark: childrenMark)
            index = index - 1
        }
    }
    
    func all() -> [Mark] {
        return stack_.reversed()
    }
}
