//
//  ThumbnailCollectionViewCell.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/15.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    func add(view:UIView) -> Void {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        view.frame = bounds
        contentView.addSubview(view)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
