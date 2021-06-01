//
//  ProductMemoryService.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import Combine

protocol ProductMemoryServiceProtocol: MemoryServiceProtocol {
    func add(productList: [Product])
    func buy(product: Product)
}

final class ProductMemoryService: ProductMemoryServiceProtocol {
    
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
    
    func buy(product: Product) {
        let storedProduct = products.first(where: { $0.productId == product.productId })
        
        if let stockCount = storedProduct?.stock,
           let quantity = product.stock {
            
            if stockCount > quantity {
                storedProduct?.stock = stockCount - quantity
            } else {
                storedProduct?.stock = 0
            }
            
        }
    }
}
