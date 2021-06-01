//
//  ServiceManager.swift
//  Clothes Store
//
//  Created by Mentor on 28.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

final class ServiceManager: ServiceManagerProvidable {
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        
        return URLSession(configuration: configuration)
    }()
    
    func get<T: Decodable>(for: T.Type, mainUrl: String, path: String = "", completion: @escaping (Result<T, Error>?) -> Void) {
        
        guard let url = URL(string: mainUrl + path) else {
            debugPrint(Strings.Errors.invalidURL.rawValue)
            completion(.failure(ErrorManager.invalidURL))
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    
                    completion(.success(response))
                }
            } catch {
                completion(.failure(ErrorManager.unknown))
            }
            
        }.resume()
    }
    
    func getImage(with imageUrl: URL, completion: @escaping (Result<Data, Error>?) -> Void) -> URLSessionTask? {
        
        let urlRequest = URLRequest(url: imageUrl)
        
        if let cachedImageData = ImageCache.shared().getImageData(with: imageUrl) {
            completion(.success(cachedImageData))
            
            return nil
        }
        
        let task = session.dataTask(with: urlRequest){ data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
                ImageCache.shared().insertImage(data: data, with: imageUrl)
            } else {
                completion(.failure(ErrorManager.unknown))
            }
        }
        
        task.resume()
        
        return task
    }
}
