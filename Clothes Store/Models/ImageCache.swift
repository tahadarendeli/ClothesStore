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
        return ImageCache()
    }()
    
    private let cache = NSCache<AnyObject, AnyObject>()
    private let queue = DispatchQueue(label: "barrier", attributes: .concurrent)
    
    private init() {
    }
    
    class func shared() -> ImageCache {
        return sharedCache
    }
    
    func getImageData(with url: URL) -> Data? {
        if let imageData = cache.object(forKey: url as AnyObject) as? Data {
            return imageData
        }
        
        return nil
    }
    
    func insertImage(data: Data, with url: URL) {
        queue.async(flags: .barrier) {
            self.cache.setObject(data as AnyObject, forKey: url as AnyObject)
        }
    }
}
