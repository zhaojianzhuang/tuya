//
//  SaveScribbleCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/7.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class SaveScribbleCommand: NSObject{
    var userinfo: [String : Any]?
   
    

}

extension SaveScribbleCommand:Command {
    func execute() -> Void {
        let canvasVC = CoordinatingController.default.canvasViewController
//        canvasVC.s
    }
    
    func undo() -> Void {
        
    }
}
