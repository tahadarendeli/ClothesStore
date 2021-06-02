//
//  WishlistPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

protocol WishlistPresentation {
    func getProducts()
    func addProductToBasket(product: ProductPresentable)
    func removeProductFromWishlist(product: ProductPresentable)
}

final class WishlistPresenter: WishlistPresentation {
    weak var view: WishlistViewProtocol?
    
    private var basketMemoryService: MemoryServiceProtocol!
    private var wishlistMemoryService: MemoryServiceProtocol!
    
    private var products : [ProductPresentable] {
        return wishlistMemoryService.get()
    }
    
    init(with view: WishlistViewProtocol, basketMemoryService: MemoryServiceProtocol, wishlistMemoryService: MemoryServiceProtocol) {
        self.view = view
        self.basketMemoryService = basketMemoryService
        self.wishlistMemoryService = wishlistMemoryService
    }
    
    func getProducts() {
        view?.updateWishlist(with: products)
    }
    
    func addProductToBasket(product: ProductPresentable) {
        basketMemoryService.add(product: product)
        
        removeProductFromWishlist(product: product)
        getProducts()
    }
    
    func removeProductFromWishlist(product: ProductPresentable) {
        wishlistMemoryService.remove(product: product)
        
        getProducts()
    }
}
