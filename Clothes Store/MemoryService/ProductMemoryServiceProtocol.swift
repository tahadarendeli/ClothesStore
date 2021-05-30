//
//  ProductMemoryServiceProtocol.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Combine

protocol ProductMemoryServiceProtocol {
    var action: PassthroughSubject<Int, Never> { get }
    
    func add(product: Product)
    func remove(product: Product)
    func get() -> [Product]
}
