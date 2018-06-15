//
//  ThumbnailViewController.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/5.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

fileprivate let ThumbnailViewControllerIdentify = "ThumbnailViewControllerIdentify"
class ThumbnailViewController: PaletteThumbnailBaseViewController {
    var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        initUI()
        
        
    }
}

//MARK:- privaet
extension ThumbnailViewController {
    fileprivate func initUI() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier:ThumbnailViewControllerIdentify)
    }
}


//MARL:- delegate
extension ThumbnailViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ScribbleManager.default.numberOfScribble()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailViewControllerIdentify, for: indexPath) as! ThumbnailCollectionViewCell
        let view = try? ScribbleManager.default.thumbnail(index: indexPath.row)
        if view != nil {
            cell.add(view: view!)
        }
//        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = try? ScribbleManager.default.thumbnail(index: indexPath.row) as? ScribbleThumbnailViewImageProxy
        guard let proxy = view else {
            return
        }
        proxy?.touchCommand?.execute()
    }
}

