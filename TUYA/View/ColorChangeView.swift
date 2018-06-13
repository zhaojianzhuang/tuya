//
//  ColorChangeView.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/13.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit




class ColorChangeView: UIView {
    var command:Command?
    let sliderViewWidth:CGFloat = 200.0
    let topBottomHeight:CGFloat = 5.0
    let titleLabbelHegiht:CGFloat = 20.0
    let sliderViewHeight:CGFloat = 30.0
    let sliderWidth:CGFloat = 170.0
    let colorViewWidth:CGFloat = 150.0
    let colorViewHeight:CGFloat = 50.0
    
    var colorView:UIView?
    var sliders:[UISlider]=[UISlider]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        command = StrokeColorCommand(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ColorChangeView:StrokeColorCommandDelegate {
    func finishUpdate(command: Command, color: UIColor) -> Void {
        colorView?.backgroundColor = color
    }
    func requestColorComponent(commad: Command, red: inout CGFloat, green: inout CGFloat, blue: inout CGFloat) -> Void {
        
        red = CGFloat(self.sliders[0].value)
        green = CGFloat(self.sliders[1].value)
        blue = CGFloat(self.sliders[2].value)
    }
}
//MARK: -private
extension ColorChangeView {
    @objc fileprivate func valuechange(slider:UISlider) -> Void {
        command?.execute()
    }
    fileprivate func initUI() -> Void {
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: titleLabbelHegiht)))
        titleLabel.textAlignment = .center
        titleLabel.text = "stroke color"
        addSubview(titleLabel)
        let labelnames = ["r", "g", "b"]
        let userDefaults = UserDefaults.standard
        let blue = userDefaults.float(forKey: CODE_BLUE_KEY)
        let red = userDefaults.float(forKey: CODE_RED_KEY)
        let green = userDefaults.float(forKey: CODE_GREEN_KEY)
//        let size = CGFloat(userDefaults.float(forKey: CODE_SIZE_KEY))
        let colors = [red, blue, green]
        for i in 0..<3 {
            let label  = UILabel(frame: CGRect(x: (frame.width - sliderViewWidth) / 2,
                                               y: titleLabbelHegiht + topBottomHeight + (sliderViewHeight + topBottomHeight) * CGFloat(i),
                                               width: sliderViewHeight,
                                               height: sliderViewHeight))
            label.text = labelnames[i]
            addSubview(label)
            
            let slider = UISlider(frame: CGRect(x: (frame.width  - sliderViewWidth) / 2 + sliderViewHeight,
                                                y: titleLabbelHegiht + topBottomHeight + (sliderViewHeight + topBottomHeight) * CGFloat(i),
                                                width: sliderWidth,
                                                height: sliderViewHeight))
            slider.value = colors[i]
            slider.addTarget(self, action: #selector(valuechange(slider:)), for: UIControlEvents.valueChanged)
            addSubview(slider)
            sliders.append(slider)
        }
        
        colorView = UIView(frame: CGRect(x: (frame.width - colorViewWidth) / 2,
                                         y: titleLabbelHegiht + topBottomHeight + (sliderViewHeight + topBottomHeight) * 3.0 + topBottomHeight,
                                         width: colorViewWidth,
                                         height: colorViewHeight))
        
        colorView?.backgroundColor = UIColor.init(red: CGFloat(sliders[0].value),
                                                  green: CGFloat(sliders[1].value),
                                                  blue: CGFloat(sliders[1].value),
                                                  alpha: 1)
        addSubview(colorView!)
    }
}


