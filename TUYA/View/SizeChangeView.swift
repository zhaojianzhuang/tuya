//
//  SizeChangeView.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/13.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class SizeChangeView: UIView {
    
    //   command for value changed
    var command:Command?
    
    var slider:UISlider?
    var leftView:UIView?
    var rightView:UIView?
    var sizeView:UIView?
    let titleLabbelHegiht:CGFloat = 20.0
    let sliderViewHeight:CGFloat = 30.0
    let sliderWidth:CGFloat = 170.0
    let leftViewWidth:CGFloat = 10
    let rightViewWidth:CGFloat = 20

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        command = StrokeSizeCommand(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
//MARK:-StrokeSizeCommandDelegate
extension SizeChangeView:StrokeSizeCommandDelegate {
    func update(command: Command, size: CGFloat) -> Void {
        var frame = sizeView?.frame
        frame?.size.height = size
        sizeView?.frame = frame!
    }
    
    func request(forStroke size: inout CGFloat, command: Command) -> Void {
        size = CGFloat(self.slider!.value)
    }
    
}
//MARK:-private
extension SizeChangeView {
    @objc fileprivate func valuechange(slider:UISlider) -> Void {
        command?.execute()
    }
    
    fileprivate func initUI() -> Void {
        slider = UISlider(frame: CGRect(x: (frame.width - sliderWidth) / 2,
                                        y: titleLabbelHegiht + 5,
                                        width: sliderWidth,
                                        height: sliderViewHeight))
        slider?.addTarget(self, action: #selector(valuechange(slider:)), for: UIControlEvents.valueChanged)
        addSubview(slider!)
        
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint.zero,
                                               size: CGSize(width: frame.width,
                                                            height: titleLabbelHegiht)))
        titleLabel.textAlignment = .center
        titleLabel.text = "stroke size"
        addSubview(titleLabel)
        
        leftView = UIView(frame: CGRect(x: (frame.width - sliderWidth) / 2 - leftViewWidth,
                                        y: titleLabbelHegiht + 5 + sliderViewHeight / 2 - leftViewWidth / 2,
                                        width: leftViewWidth,
                                        height: leftViewWidth));
        leftView?.backgroundColor = UIColor.black
        addSubview(leftView!)
        
        rightView = UIView(frame: CGRect(x: (frame.width + sliderWidth) / 2,
                                         y: titleLabbelHegiht + 5 + sliderViewHeight / 2 - rightViewWidth / 2,
                                         width: rightViewWidth,
                                         height: rightViewWidth))
        rightView?.backgroundColor = UIColor.black
        addSubview(rightView!)
        let userDefaults = UserDefaults.standard
        let size = userDefaults.float(forKey: CODE_SIZE_KEY)
        let height = size == 0 ? Float(STROKE_SIZE_MIN) : size
        slider?.value = size / Float(STROKE_SIZE_MAX - STROKE_SIZE_MIN)
        
        
        sizeView = UIView(frame: CGRect(x: 0,
                                        y: titleLabbelHegiht + 5 + 5 + sliderViewHeight,
                                        width: frame.width,
                                        height: CGFloat(height)))
        sizeView?.backgroundColor = UIColor.black
        addSubview(sizeView!)
    }
}






