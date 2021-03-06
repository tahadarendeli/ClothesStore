//
//  BasketMemoryService.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import Combine

final class BasketMemoryService: MemoryServiceProtocol {
    
    private static let sharedMemoryService: BasketMemoryService = .init()
    
    let action = PassthroughSubject<Int, Never>()
    
    private var products: [ProductPresentable] = [] {
        didSet {
            action.send(products.count)
        }
    }
    
    private init() { }
    
    class func shared() -> BasketMemoryService {
        return sharedMemoryService
    }
    
    func add(product: ProductPresentable) {
        if products.contains(where: { $0.productId == product.productId }) {
            
            if let index = products.firstIndex(where: { $0.productId == product.productId }),
               let basketStockCount = products[index].stock,
               let productStockCount = product.stock,
               basketStockCount < productStockCount {
                    products[index].stock = basketStockCount + 1
            }
            
        } else if let stock = product.stock, stock > 0 {
    
            var newProduct = product.copy()
            newProduct.stock = 1
            
            products.append(newProduct)
            
        }
    }
    
    func remove(product: ProductPresentable) {
        if let index = products.firstIndex(where: { $0.productId == product.productId }) {
            products.remove(at: index)
            
        }
    }
    
    func get() -> [ProductPresentable] {
        return products
    }
}
