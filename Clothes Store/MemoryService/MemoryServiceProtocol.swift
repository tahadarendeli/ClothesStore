//
//  MemoryServiceProtocol.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Combine

protocol MemoryServiceProtocol {
    func add(product: Product)
    func add(productList: [Product])
    func remove(product: Product)
    func get() -> [Product]
}

extension MemoryServiceProtocol {
    func add(product: Product) { }
    func add(productList: [Product]) { }
    func remove(product: Product) { }
}
