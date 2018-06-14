//
//  StrokeColorCommand.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/13.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//  the protocol for stroke color
protocol StrokeColorCommandDelegate:NSObjectProtocol {
    
    ///   command execute finsh update
    ///   we can use this color to alter color
    func finishUpdate(command:Command,
                      color:UIColor) -> Void
    
    ///   request current color component
    ///   use three pointer to affect inner
    ///   we can use this to tell the delegate current rgb
    func requestColorComponent(commad:Command,
                               red:inout CGFloat,
                               green:inout CGFloat,
                               blue:inout CGFloat) -> Void
}

/// equal to requestColorComponent
typealias RGBValueProvider = (_ red:inout CGFloat,  _ green:inout CGFloat, _ blue:inout CGFloat) -> ()

/// equal to finishUpdate
typealias PostColorUpdateColor = (_ color:UIColor) -> Void




class StrokeColorCommand:NSObject, Command {
    var userinfo: [String : Any]?
    weak var delegate:StrokeColorCommandDelegate?
    var provider:RGBValueProvider?
    var updateor:PostColorUpdateColor?
    
    init(delegate:StrokeColorCommandDelegate?) {
        self.delegate = delegate;
        super.init()
    }
    
    func execute() -> Void {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        
        delegate?.requestColorComponent(commad: self,
                                        red: &red,
                                        green: &green,
                                        blue: &blue)
        provider?(&red, &green, &blue)
        
        let color = UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
        //        work at canvasView
        let vc = CoordinatingController.default.canvasViewController
        vc.strokeColor = color
        
        //        update delegate
        delegate?.finishUpdate(command: self, color: color)
        updateor?(color)
        
        //        save color
        let userDefaults = UserDefaults.standard
        userDefaults.set(Float(blue), forKey: CODE_BLUE_KEY)
        userDefaults.set(Float(red), forKey: CODE_RED_KEY)
        userDefaults.set(Float(green), forKey: CODE_GREEN_KEY)
        
    }
    
    
    func undo() -> Void {
        
    }
}






