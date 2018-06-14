//
//  ScribbleManager.swift
//  TUYA
//
//  Created by jianzhuangzhao on 2018/6/6.
//  Copyright © 2018年 ZJZ. All rights reserved.
//

import UIKit

//    get dir in document path
func getDocument(dir:String) -> String {
    return ((NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                 FileManager.SearchPathDomainMask.userDomainMask,
                                                 true).first!)as NSString)
        .appendingPathComponent(dir)
}


//thumbnail dir
let THUMBNAILSDIR = "thumbnails"
//data dir
let DATADIR = "data"


class ScribbleManager: NSObject {
    //    single
    static let `default` = ScribbleManager(dataPath: getDocument(dir: DATADIR),
                                           thumbnailsPath: getDocument(dir: THUMBNAILSDIR))
    //    thumail path
    fileprivate var thumbnailPath:String {
        return getDocument(dir: THUMBNAILSDIR)
    }
    //    data path
   fileprivate var dataPath:String {
        return getDocument(dir: DATADIR)
    }
    //    the files under data dir
    fileprivate var dataDirPaths:[String]? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: dataPath) {
            let paths = try? FileManager.default.contentsOfDirectory(atPath: dataPath)
            return paths
        }
        return nil
    }
    //    the file under thumail dir
    fileprivate var thumbnailPaths:[String]? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: THUMBNAILSDIR) {
            let paths = try? FileManager.default.contentsOfDirectory(atPath: THUMBNAILSDIR)
            return paths
        }
        return nil
    }
    
    
    init(dataPath:String, thumbnailsPath:String) {
        if !FileManager.default.fileExists(atPath: dataPath) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error occured with create datadir")
            }
        }
        if !FileManager.default.fileExists(atPath: thumbnailsPath) {
            do {
                try FileManager.default.createDirectory(atPath: thumbnailsPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error occured with create thumbnailsDir")
            }
        }
        super.init()
    }
    
}

//MARK: -interface
extension ScribbleManager {
    
    //    save
    func save(scribble:Scribble, thumbnail:UIImage) -> Void {
        let newIndex = numberOfScribble() + 1
        let scribleDataName = "data_\(newIndex)"
        let thumbnailName = "thumbnail_\(newIndex)"
        
        guard let scribleMemento = scribble.scribbleMemento else {
            print("save occur error with scrible")
            return
        }
        let scribleData = scribleMemento.data()
        
        do {
            try scribleData.write(to: URL.init(fileURLWithPath: scribleDataName))
        }
        catch {
            print("save scrible error occur:\(error)")
        }
        
        let imageDataOptional = UIImagePNGRepresentation(thumbnail)
        guard let imageData =  imageDataOptional else {
            print("save occur error with thumail")
            return
        }
        
        do {
            try imageData.write(to: URL.init(fileURLWithPath: thumbnailName))
        }
        catch {
            print("save thunail error occur:\(error)")
        }
    }
    
    //    number
    func numberOfScribble() -> Int {
        return dataDirPaths==nil ? 0:dataDirPaths!.count
    }
    //    get scrible with index
    func scrilbe(index:Int) throws -> Scribble {
        guard let dataDir = dataDirPaths else {
            throw ScribbleError.notSoManyScribleError
        }
        if dataDir.count <= index {
            throw ScribbleError.notSoManyScribleError
        }
        
        let path = dataDir[index]
        let fileManager = FileManager.default
        let data = fileManager.contents(atPath: path)
        
        guard let fileContent = data else {
            throw ScribbleError.notContentAtPath
        }
        
        do {
             let scribbleMemento = try ScribbleMemento(data: fileContent)
            return  Scribble(memento: scribbleMemento, manager:nil)
        } catch  {
            throw error
        }
    }
    //    get thumbnail with index
    func thumbnail(index:Int) throws -> UIView {
        guard let thumbnailDir = thumbnailPaths else {
            throw ScribbleError.notSoManyThumailError
        }
        if thumbnailDir.count <= index {
            throw ScribbleError.notSoManyScribleError
        }
        let thumailPath = thumbnailDir[index]
        
        guard let dataDir = dataDirPaths else {
            throw ScribbleError.notSoManyThumailError
        }
        if dataDir.count <= index {
            throw ScribbleError.notSoManyScribleError
        }
        let dataPath = dataDir[index]
        
        let loadedScribbleThumbnail = ScribbleThumbnailViewImageProxy()
        loadedScribbleThumbnail.imagePath = (ScribbleManager.default.thumbnailPath as NSString).appendingPathComponent(thumailPath)
        loadedScribbleThumbnail.scribblePath = (ScribbleManager.default.dataPath as NSString).appendingPathComponent(dataPath)
        
        loadedScribbleThumbnail.touchCommand = OpenScribbleCommand<ScribbleThumbnailViewImageProxy>(aScribbleSource: loadedScribbleThumbnail)
        return loadedScribbleThumbnail
    }
}

//MARK:-private
extension ScribbleManager {
    
    
}



