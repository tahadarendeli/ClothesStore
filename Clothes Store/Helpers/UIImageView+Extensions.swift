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
    
    struct TaskHolder {
        static var task: URLSessionTask?
    }
    
    private var task: URLSessionTask? {
        get {
            return TaskHolder.task
        }
        
        set(newTask) {
            TaskHolder.task = newTask
        }
    }
    
    func getImage(with url: URL, completion: ((UIImage?) -> ())? = nil) {
        task = ImageServiceManager.getImage(with: url, completion: { image in
            DispatchQueue.main.async {
                self.image = image
                completion?(image)
            }
        })
    }
    
    func cancelImageRequest() {
        task?.cancel()
    }
}

