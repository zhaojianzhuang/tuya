//
//  ScribbleThumbnailViewImageProxy.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/12.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class ScribbleThumbnailViewImageProxy: ScribbleThumbnailView {
    var touchCommand:Command?
    var scribble_:Scribble?
    var realImage_:UIImage?
    
    private var loadingThreadHasLaunched_ = false
    
    override var image: UIImage? {
        if realImage_ == nil {
            realImage_ = UIImage(contentsOfFile: imagePath!)
        }
        return realImage_
    }
    
    override func scribble() throws -> Scribble {
        if scribble_ != nil {
            return scribble_!
        }
        let fileManager =  FileManager.default
        let contents = fileManager.contents(atPath: scribblePath!)
        guard let data = contents else { throw ProxyError.dataEmpty }
        do {
            let scribble = try ScribbleMemento.memento(data: data)
            return Scribble(memento: scribble, manager: nil)
        } catch {
            throw error
        }
    }
    
    override func draw(_ rect: CGRect) {
        if realImage_ == nil {
            let context = UIGraphicsGetCurrentContext()
            context?.setLineWidth(10.0)
            context?.setStrokeColor(UIColor.darkGray.cgColor)
            context?.setFillColor(UIColor.lightGray.cgColor)
            context?.addRect(rect)
            context?.drawPath(using: .fillStroke)
            if !loadingThreadHasLaunched_ {
                self.performSelector(inBackground: #selector(forwardImageLoadingThread), with: nil)
                loadingThreadHasLaunched_ = true
            }
        } else {
            realImage_?.draw(in: rect)
        }
    }
    @objc func forwardImageLoadingThread() -> Void {
        let _ = self.image
        self.setNeedsDisplay()
//        self.performSelector(inBackground: #selector(setNeedsDisplay), with: nil)
    }
    
    
    
}



