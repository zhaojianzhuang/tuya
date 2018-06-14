//
//  DeleteScribbleCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//clear current canvasViewController's scribble
//this can make the scribble be empty 
class ClearScribbleCommand: NSObject, Command {
    var userinfo: [String : Any]?
    
    func execute() -> Void {
        let vc = CoordinatingController.default.canvasViewController
        vc.clearScribble()
    }
    
    func undo() -> Void {
        
    }
}

