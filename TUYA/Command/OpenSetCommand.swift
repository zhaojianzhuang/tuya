//
//  OpenSetCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/14.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//use this to open set controller
class OpenSetCommand:NSObject, Command {
    var userinfo: [String : Any]?
    
    func execute() -> Void {
        let palletvc = PaletteViewController()
        let nav = UINavigationController(rootViewController: palletvc)
        CoordinatingController.default.present(viewController: nav,
                                               animated: true,
                                               completion: nil)
    }
    
    func undo() -> Void {
        
    }
}

