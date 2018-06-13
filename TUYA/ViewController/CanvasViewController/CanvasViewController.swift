//
//  CanvasViewController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit


class CanvasViewController: UIViewController {
    
    var size:CGFloat {
        set {
            if newValue < 5.0 {
                size_ = 5.0
            } else {
                size_ = newValue
            }
        }
        get {
            return size_
        }
    }
    var strokeColor:UIColor?
    
    
    let toolbar_Hegiht:CGFloat = 60
    var scribble = Scribble()
    var canvasView:CanvasView?
//    fileprivate var color_:UIColor?
    fileprivate var size_:CGFloat = 5.0
    
    fileprivate var startPoint_:CGPoint?
    fileprivate var endPoint_:CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scribble.addObserver(self, forKeyPath: "mark", options: NSKeyValueObservingOptions.new, context: nil)
        loadCanvasView(type: CanvasViewType.cloth)
        initToolbar()
        
        let userDefaults = UserDefaults.standard
        let blue = CGFloat(userDefaults.float(forKey: CODE_BLUE_KEY))
        let red = CGFloat(userDefaults.float(forKey: CODE_RED_KEY))
        let green = CGFloat(userDefaults.float(forKey: CODE_GREEN_KEY))
        let size = CGFloat(userDefaults.float(forKey: CODE_SIZE_KEY))
        size_ = size < 5.0 ? 5.0 : size
        strokeColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    @IBAction func BarButtonItem(_ sender: Any) {
        
    }
    

    
}

//MARK:- override
extension CanvasViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint_ = touches.first?.location(in: canvasView)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        endPoint_ = touches.first?.previousLocation(in: canvasView)
        guard let startPoint = startPoint_ else { return }
        guard let endPoint = endPoint_ else { return }
        if endPoint.equalTo(startPoint) {
            let newStroke = Stroke()
            newStroke.color = strokeColor
            newStroke.size = size_
            scribble.add(amark: newStroke, shouldAddToPreviousMark: false)
        }
        let point = touches.first?.location(in: canvasView)
        guard let thisPoint = point else { return   }
        let vertex = Vertex(location: thisPoint)
        scribble.add(amark: vertex, shouldAddToPreviousMark: true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let last = touches.first?.previousLocation(in: canvasView)
        let this = touches.first?.location(in: canvasView)
        guard let lastPoint = last else { return  }
        guard let thisPoint = this else { return  }
        if lastPoint.equalTo(thisPoint) {
            let singleDot = Dot(location: thisPoint)
            singleDot.color = strokeColor
            singleDot.size = size_
            scribble.add(amark: singleDot, shouldAddToPreviousMark: false)
        }
        startPoint_ = CGPoint.zero
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint_ = CGPoint.zero
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is Scribble && keyPath == "mark" {
            guard let dic = change else { return }
            let newchange = dic[NSKeyValueChangeKey.newKey]
            guard let mark = newchange as? Mark else { return }
            canvasView?.mark = mark
            
            canvasView?.setNeedsDisplay()
        }
    }
}


extension CanvasViewController {
    
    
    
    @objc fileprivate func barButtonItem(_ sender:UIBarButtonItem) -> Void{
        CoordinatingController.default.requestChange(object: sender)
    }
    fileprivate func initToolbar()->Void {
        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: SCREEN_Height - toolbar_Hegiht,
                                              width: SCREEN_WIDTH,
                                              height: toolbar_Hegiht))
        
        //        删除
        let trash = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(barButtonItem(_:)))
        
        //        保存
        let save = UIBarButtonItem(image: UIImage(named: "save.png") , style: UIBarButtonItemStyle.done, target: self, action: #selector(barButtonItem(_:)))
        
        //        打开
        let open = UIBarButtonItem(image: UIImage(named: "open.png") , style: UIBarButtonItemStyle.done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(object:)))
        open.tag = ButtonTag.kButtonTagOpenThumbnailView.rawValue
        
        //        颜色
        let palette = UIBarButtonItem(image: UIImage(named: "palette.png") , style: UIBarButtonItemStyle.done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(object:)))
        palette.tag = ButtonTag.kButtonTagOpenPaletteView.rawValue
        
        let undo = UIBarButtonItem(image: UIImage(named: "undo.png") , style: UIBarButtonItemStyle.done, target: self, action: #selector(barButtonItem(_:)))
        let redo = UIBarButtonItem(image: UIImage(named: "redo.png") , style: UIBarButtonItemStyle.done, target: self, action: #selector(barButtonItem(_:)))
        //
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.items = [flex, trash, flex, save, flex, open, flex, palette, flex, undo, flex, redo, flex]
        view.addSubview(toolbar)
    }
}

//MARK:- privae
extension CanvasViewController {
    fileprivate func loadCanvasView(type:CanvasViewType) -> Void {
        canvasView = CanvasViewGenerator.create(frame: CGRect(x: 0, y: 0,
                                                                  width: SCREEN_WIDTH, height: SCREEN_Height) ,
                                                    type: CanvasViewType.cloth)
        view.addSubview(canvasView!)
    }
}

