//
//  MemoryServiceProtocol.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Combine

protocol MemoryServiceProtocol {
    func add(product: ProductPresentable)
    func remove(product: ProductPresentable)
    func get() -> [ProductPresentable]
}

extension MemoryServiceProtocol {
    func add(product: ProductPresentable) { }
    func remove(product: ProductPresentable) { }
}
