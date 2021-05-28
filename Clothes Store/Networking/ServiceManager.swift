//
//  ServiceManager.swift
//  Clothes Store
//
//  Created by Mentor on 28.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
final class ServiceManager {
    
    static func get<T: Decodable>(for: T.Type, mainUrl: String, path: String = "", completion: @escaping (T?, Error?) -> Void ) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        
        let session = URLSession(configuration: configuration)
        
        let mainUrl = mainUrl
        guard let url = URL(string: mainUrl + path) else {
            debugPrint("Invalid URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest){ data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                let response = try? decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response, error)
                }
            }
        }.resume()
    }
}
