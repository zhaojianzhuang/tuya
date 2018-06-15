//
//  OpenThumbnailCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/15.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class OpenThumbnailCommand: Command {
    var userinfo: [String : Any]?
    
    func execute() -> Void {
        let palletvc = ThumbnailViewController()
        let nav = UINavigationController(rootViewController: palletvc)
        CoordinatingController.default.present(viewController: nav,
                                               animated: true,
                                               completion: nil)
    }
    
    func undo() -> Void {
        
    }
}
