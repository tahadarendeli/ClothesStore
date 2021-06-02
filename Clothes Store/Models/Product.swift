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

extension Product: ProductPresentable {
    var presentablePrice: String? {
        return CurrencyHelper.getMoneyString(price ?? 0)
    }
    
    func copy() -> ProductPresentable {
        let newProduct = Product()
        
        newProduct.productId = productId
        newProduct.name = name
        newProduct.category = category
        newProduct.price = price
        newProduct.stock = stock
        newProduct.oldPrice = oldPrice
        newProduct.image = image
        
        return newProduct
    }
}

protocol ProductPresentable {
    var productId: String? { get }
    var name: String? { get }
    var category: Category? { get }
    var price: Float? { get }
    var presentablePrice: String? { get }
    var stock: Int? { get set }
    var oldPrice: Float? { get }
    var image: String? { get }
    
    func copy() -> ProductPresentable
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


