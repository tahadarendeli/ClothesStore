//
//  DataService.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation

final class ProductsDataService {
    
    class func getProducts(completion: @escaping (Result<Products, Error>?) -> Void) {
        
        let requestUrl = URLCall.catalogue.rawValue
        
        ServiceManager.get(for: Products.self, mainUrl: requestUrl, completion: { result in
            completion(result)
        })
    }
}
