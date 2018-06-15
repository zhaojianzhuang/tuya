//
//  UIView+Image.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/15.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit


extension UIView {
    /// get the screen render export a image
    func image() -> UIImage? {
        let imageSize = self.bounds.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0);
        let contextOptional = UIGraphicsGetCurrentContext()
        for window in UIApplication.shared.windows {
            if !window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                
                guard let context = contextOptional else { return nil }
                
                context.saveGState()
                
                context.ctm.translatedBy(x: window.center.x,
                                         y: window.center.y)
                
                context.ctm.concatenating(window.transform)
                
                context.ctm.translatedBy(x: window.bounds.size.width * window.layer.anchorPoint.x,
                                          y: -window.bounds.size.height * window.layer.anchorPoint.y)
                
                window.layer.render(in: context)
                context.restoreGState()
            }

        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

