//
//  StrokeSizeCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/13.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

protocol StrokeSizeCommandDelegate:NSObjectProtocol {
    func request(forStroke size:inout CGFloat, command:Command) -> Void
    func update(command:Command, size:CGFloat) ->Void 
}

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
        let vc = CoordinatingController.default.canvasViewController
        let strokeSize = size * 20 + 5
        vc.size = strokeSize
        delegate?.update(command:self , size: strokeSize)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(CGFloat(strokeSize), forKey: CODE_SIZE_KEY)
    }
    
    func undo() -> Void {
        
    }
    
   
}
