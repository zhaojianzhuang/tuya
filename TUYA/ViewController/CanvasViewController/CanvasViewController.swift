//
//  CanvasViewController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    ///  mark size outside
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
    
    ///  current stroke color
    var strokeColor:UIColor?
    
    ///  because this controller's scribble must be observer
    ///  so we use scrible_ inner and use scribble outside
    ///  in scribble set method, we add the observer
    
    ///  visit inner
    fileprivate var scribble_ = Scribble()
    ///  visit outside
    var scribble:Scribble {
        set {
            scribble_.clear()
            scribble_.add(amark: newValue.mark as! Mark)
//            scribble_.add(amark: newValue)
            
//            scribble_.addObserver(self, forKeyPath: "mark", options: NSKeyValueObservingOptions.new, context: nil)
        }
        get {
           return scribble_
        }
    }
    
    let toolbar_Hegiht:CGFloat = 60
    
    var canvasView:CanvasView?
    
    ///  mark size inner
    fileprivate var size_:CGFloat = 5.0
    
    fileprivate var startPoint_:CGPoint?
    fileprivate var endPoint_:CGPoint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scribble_.addObserver(self, forKeyPath: "mark", options: NSKeyValueObservingOptions.new, context: nil)
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
}

//MARK:- override
extension CanvasViewController {
    func clearScribble() -> Void {
        scribble_.clear()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint_ = touches.first?.location(in: canvasView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        endPoint_ = touches.first?.previousLocation(in: canvasView)
        
        guard let startPoint = startPoint_ else { return }
        guard let endPoint = endPoint_ else { return }
        //    during moving if before point equal to this point that can think of a new stroke coming into being
        if endPoint.equalTo(startPoint) {
            let newStroke = Stroke()
            newStroke.color = strokeColor
            newStroke.size = size_
            scribble_.add(amark: newStroke, shouldAddToPreviousMark: false)
        }
        let point = touches.first?.location(in: canvasView)
        guard let thisPoint = point else { return   }
        let vertex = Vertex(location: thisPoint)
        
        scribble_.add(amark: vertex, shouldAddToPreviousMark: true)
    }
    @objc func remove(obj:NSObject) -> Void {
        //        scribble.remove(mark: mark)
        guard let mark = obj as? Mark else {return}
        
        scribble_.remove(mark: mark)
    }
    @objc func add(obj:NSObject) -> Void {
        guard let mark = obj as? Mark else {return}
        scribble_.add(amark: mark)
        undoManager?.registerUndo(withTarget: self, selector: #selector(remove(obj:)), object: mark)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        let last = touches.first?.previousLocation(in: canvasView)
        let this = touches.first?.location(in: canvasView)
        guard let lastPoint = last else { return  }
        guard let thisPoint = this else { return  }
        //    in the end if before point equal to this point that can think of a dot
        if lastPoint.equalTo(thisPoint) {
            let singleDot = Dot(location: thisPoint)
            singleDot.color = strokeColor
            singleDot.size = size_
            undoManager?.registerUndo(withTarget: self, selector: #selector(remove(obj:)), object: singleDot)
            scribble_.add(amark: singleDot, shouldAddToPreviousMark: false)
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

//MARK: -private
extension CanvasViewController {
    fileprivate func initToolbar()->Void {
        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: SCREEN_Height - toolbar_Hegiht,
                                              width: SCREEN_WIDTH,
                                              height: toolbar_Hegiht))
        
        let clearCommand = ClearScribbleCommand()
        //    clear
        let trashItem = CommandBarButtonItem(command: clearCommand, image: UIImage(named: "clear.png"), style: .done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(button:)), title: nil)
        let saveCommand = SaveScribbleCommand()
        //        save
        let saveItem = CommandBarButtonItem(command: saveCommand, image: UIImage(named: "save.png"), style: .done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(button:)), title: nil)
        //        open
        let openCommand = OpenThumbnailCommand()
        let openItem = CommandBarButtonItem(command: openCommand, image: UIImage(named: "open.png"), style: .done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(button:)), title: nil)
        
        let setCommand = OpenSetCommand()
        //        set
        let setItem = CommandBarButtonItem(command: setCommand, image: UIImage(named: "palette.png"), style: .done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(button:)), title: nil)
        
        let undoCommand = UndoCommand(delegate: self)
        scribble_.revocationDelegate = undoCommand
        //        undo
        let undoItem = CommandBarButtonItem(command: undoCommand, image: UIImage(named: "undo.png"), style: .done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(button:)), title: nil)
        //        redo
        let redoCommand = RedoCommand(delegate: self)
        scribble_.revocationAgainstDelegate = redoCommand
        let redoItem = CommandBarButtonItem(command: redoCommand, image: UIImage(named: "redo.png"), style: .done, target: CoordinatingController.default, action: #selector(CoordinatingController.requestChange(button:)), title: nil)
        //        flex
        let flexItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.items = [flexItem, trashItem, flexItem, saveItem, flexItem, openItem, flexItem, setItem, flexItem, undoItem, flexItem, redoItem, flexItem]
        view.addSubview(toolbar)
    }
}
//MARK:-RedoCommandDelegate
extension CanvasViewController:RedoCommandDelegate {
    func redo(command:Command) -> Void {
        scribble_.manager.redo()
    }
}
//MARK:-UndoCommandDelegate
extension CanvasViewController:UndoCommandDelegate {
    func undo(command:Command) -> Void {
        scribble_.manager.undo()
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
