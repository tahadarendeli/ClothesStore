//
//  WishlistMemoryService.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import Combine

final class WishlistMemoryService: MemoryServiceProtocol {
    
    private static let sharedMemoryService: WishlistMemoryService = .init()
    
    let action = PassthroughSubject<Int, Never>()
    
    private var products: [ProductPresentable] = [] {
        didSet {
            action.send(products.count)
        }
    }
    
    private init() { }
    
    class func shared() -> WishlistMemoryService {
        return sharedMemoryService
    }
    
    func add(product: ProductPresentable) {
        guard products.contains(where: { $0.productId == product.productId }) else {
            products.append(product)
            
            return
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
