//
//  ServiceManagerProvidable.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

protocol ServiceManagerProvidable {
    func get<T: Decodable>(for: T.Type, mainUrl: String, path: String, completion: @escaping (Result<T, Error>?) -> Void)
    func getImage(with imageUrl: URL, completion: @escaping (Result<Data, Error>?) -> Void) -> URLSessionTask?
}

extension ServiceManagerProvidable {
    func get<T: Decodable>(for: T.Type, mainUrl: String, completion: @escaping (Result<T, Error>?) -> Void) {
        get(for: T.self, mainUrl: mainUrl, path: "", completion: { result in
            completion(result)
        })
    }
}
