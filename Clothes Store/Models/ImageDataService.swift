//
//  ImageDataService.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit

final class ImageDataService: DataServiceProtocol {
    var service: ServiceManagerProvidable {
        return BaseServiceManager.service
    }
    
    func getImage(with imageUrl: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionTask? {
        let task = service.getImage(with: imageUrl, completion: { result in
            guard let result = result else { return }
            
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
        
        return task
    }
}
