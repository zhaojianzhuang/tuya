//
//  OpenScribbleCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/12.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class OpenScribbleCommand<T>: Command where T:ScribbleSource {
    let aScribbleSource_:T
    init(aScribbleSource:T) {
        aScribbleSource_ = aScribbleSource
    }
    
    var userinfo: [String : Any]?
    
    func execute() -> Void {
        do {
            let scribble = try aScribbleSource_.scribble()
            let coordinateVC = CoordinatingController.default
            coordinateVC.canvasViewController.scribble = scribble
            coordinateVC.activeViewController.dismiss(animated: true, completion: nil)
        } catch  {
            print("\(error)")
        }
    }
    
    func undo() -> Void {
        
    }
    
    
}

