//
//  UIImage+Extensions.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    final class TaskHolder {
        private static let sharedTaskHolder: TaskHolder = .init()
        
        private init() { }
        
        class func shared() -> TaskHolder {
            return sharedTaskHolder
        }
        
        var task: URLSessionTask?
        
        func cancelTask() {
            task?.cancel()
        }
    }
    
    private var taskHolder: TaskHolder {
        get {
            return TaskHolder.shared()
        }
    }
    
    func getImage(with url: URL, completion: ((UIImage?) -> ())? = nil) {
        taskHolder.task = ImageDataService().getImage(with: url, completion: { image in
            DispatchQueue.main.async {
                self.image = image
                completion?(image)
            }
        })
    }
    
    func cancelImageRequest() {
        taskHolder.cancelTask()
    }
}

