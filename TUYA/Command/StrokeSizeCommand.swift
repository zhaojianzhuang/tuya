//
//  StrokeSizeCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/13.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit
//  the protocol for stroke size
protocol StrokeSizeCommandDelegate:NSObjectProtocol {
    
    ///   command execute finsh update
    ///   we can use this size to alter size
    func request(forStroke size:inout CGFloat, command:Command) -> Void
    
    ///   request current size
    ///   use a pointer to affect inner
    ///   we can use this to tell the delegate current size
    func update(command:Command, size:CGFloat) ->Void
}

/// equal to request
typealias StrokeSizeProvider = (_ size:inout CGFloat) -> Void

class StrokeSizeCommand: NSObject, Command {
    weak var delegate:StrokeSizeCommandDelegate?
    var provider:StrokeSizeProvider?
    init(delegate:StrokeSizeCommandDelegate?) {
        self.delegate = delegate
        super.init()
    }
    
    var userinfo: [String : Any]?
    
    func execute() -> Void {
        var size:CGFloat = 0
        delegate?.request(forStroke: &size, command: self)
        provider?(&size)
        //    work at canvasView
        let vc = CoordinatingController.default.canvasViewController
        let strokeSize = size * (STROKE_SIZE_MAX  - STROKE_SIZE_MIN) + STROKE_SIZE_MIN
        vc.size = strokeSize
        //     update
        delegate?.update(command:self , size: strokeSize)
        
        //      save
        let userDefaults = UserDefaults.standard
        userDefaults.set(CGFloat(strokeSize), forKey: CODE_SIZE_KEY)
    }
    
    func undo() -> Void {
        
    }
    
    
}

