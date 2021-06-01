//
//  WishlistPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

protocol WishlistPresentation {
    func getProducts()
    func addProductToBasket(product: Product)
    func removeProductFromWishlist(product: Product)
}

final class WishlistPresenter: WishlistPresentation {
    weak var view: WishlistViewProtocol?
    
    private var basketMemoryService = BasketMemoryService.shared()
    private var wishlistMemoryService = WishlistMemoryService.shared()
    
    private var products : [Product] {
        return wishlistMemoryService.get()
    }
    
    init(with view: WishlistViewProtocol) {
        self.view = view
    }
    
    func getProducts() {
        view?.updateWishlist(with: products)
    }
    
    func addProductToBasket(product: Product) {
        basketMemoryService.add(product: product)
        
        removeProductFromWishlist(product: product)
        getProducts()
    }
    
    func removeProductFromWishlist(product: Product) {
        wishlistMemoryService.remove(product: product)
        
        getProducts()
    }
}
