//
//  ProductMemoryService.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import Combine

class ProductMemoryService: MemoryServiceProtocol {
    
    private static let sharedMemoryService: ProductMemoryService = .init()
    
    private var products: [Product] = []
    
    private init() { }
    
    class func shared() -> ProductMemoryService {
        return sharedMemoryService
    }
    
    func add(productList: [Product]) {
        products.append(contentsOf: productList)
    }
    
    func remove(product: Product) {
        if let index = products.firstIndex(where: { $0.productId == product.productId }) {
            products.remove(at: index)
        }
    }
    
    func get() -> [Product] {
        return products
    }
}
