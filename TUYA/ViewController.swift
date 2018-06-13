//
//  ViewController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad(){
        super.viewDidLoad()
        CoordinatingController.default.set(activeViewController: self)
    }
}

