//
//  ImageCache.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

final class ImageCache {
    
    private static var sharedCache: ImageCache = {
        let imageCache = ImageCache()
        
        return imageCache
    }()
    
    private let cache = NSCache<AnyObject, AnyObject>()
    private let lock = NSLock()
    
    private init() {
    }
    
    class func shared() -> ImageCache {
        return sharedCache
    }
    
    func getImageData(with url: URL) -> Data? {
        lock.lock(); defer { lock.unlock() }
        
        if let imageData = cache.object(forKey: url as AnyObject) as? Data {
            return imageData
        }
        
        return nil
    }
    
    func insertImage(data: Data, with url: URL) {
        lock.lock(); defer { lock.unlock() }
        
        cache.setObject(data as AnyObject, forKey: url as AnyObject)
    }
}
