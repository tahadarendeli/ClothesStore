//
//  ServiceManager.swift
//  Clothes Store
//
//  Created by Mentor on 28.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

final class ServiceManager {
    
    static func get<T: Decodable>(for: T.Type, mainUrl: String, path: String = "", completion: @escaping (Result<T, Error>?) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        
        let session = URLSession(configuration: configuration)
        
        guard let url = URL(string: mainUrl + path) else {
            debugPrint("Invalid URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                let response = try? decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    if let response = response {
                        completion(.success(response))
                    }
                }
            }
            
        }.resume()
    }
    
    static func getImage(with imageUrl: URL, completion: @escaping (Data) -> Void) -> URLSessionTask? {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        
        let session = URLSession(configuration: configuration)
        let urlRequest = URLRequest(url: imageUrl)
        
        if let cachedImageData = ImageCache.shared().getImageData(with: imageUrl) {
            DispatchQueue.main.async {
                completion(cachedImageData)
            }
            
            return nil
        }
        
        let task = session.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else {
                debugPrint(error.debugDescription)
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
                ImageCache.shared().insertImage(data: data, with: imageUrl)
            }
        }
        
        task.resume()
        
        return task
    }
}
