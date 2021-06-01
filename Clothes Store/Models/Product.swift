//
//  Product
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation

// MARK: - Products
struct Products: Codable, Identifiable {
    var id: String?
    var products: [Product]?
}

// MARK: - Product
final class Product: Codable {
    var productId, name: String?
    var category: Category?
    var price: Float?
    var stock: Int?
    var oldPrice: Float?
    var image: String?
}

extension Product: Identifiable {
    var id: String? {
        return productId
    }
}

extension Product {
    static func copy(of product: Product) -> Product {
        let newProduct = Product()
        
        newProduct.productId = product.productId
        newProduct.name = product.name
        newProduct.category = product.category
        newProduct.price = product.price
        newProduct.stock = product.stock
        newProduct.oldPrice = product.oldPrice
        newProduct.image = product.image
        
        return newProduct
    }
}

enum Category: String, Codable {
    case pants = "Pants"
    case shoes = "Shoes"
    case tops = "Tops"
}

// MARK: - Cart
struct Cart: Codable {
    let cartId, productId: Int?
}


