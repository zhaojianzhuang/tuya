//
//  DismissCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//dismiss command
//command.execute == self.dismiss 
class DismissCommand:NSObject, Command {
    var userinfo: [String : Any]?
    func execute() ->Void {
        let currentVC = CoordinatingController.default.activeViewController
        currentVC.dismiss(animated: true, completion: nil)
    }
    func undo() -> Void {
        
    }
}
