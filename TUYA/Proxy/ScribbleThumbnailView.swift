//
//  ScribbleThumbnailView.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/12.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class ScribbleThumbnailView: UIView, ScribbleSource {
    var image:UIImage?{
        return nil
    }
    var scribblePath:String?
    var imagePath:String?
    var scrible:Scribble?
    
    
    func scribble() throws -> Scribble {
        fatalError("abstrace class")
    }
    

}

