//
//  ScribbleError.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//



enum ScribbleError:Error {
    case wrongDataError,   // data wrong
    incrementalEmptyError, // empty happen
    notSoManyScribleError, // boundary
    notSoManyThumailError, // boundary
    notContentAtPath,      // visit a empty data
    notMarkWithData,       // the mark with no data 
    notImageWithData       // visit a empty image
}

