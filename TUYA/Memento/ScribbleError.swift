//
//  ScribbleError.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//



enum ScribbleError:Error {
    case wrongDataError,
         incrementalEmptyError,
         notSoManyScribleError,
         notSoManyThumailError,
         notContentAtPath,
         notMarkWithData,
         notImageWithData
}
