//
//  DetailPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

protocol DetailPresentation {
    var product: ProductPresentable! { get set }
    
    func addProductToWishlist()
    func addProductToBasket()
}

final class DetailPresenter: DetailPresentation {
    weak var view: DetailViewProtocol?
    
    private var basketMemoryService: BasketMemoryService!
    private var wishlistMemoryService: WishlistMemoryService!
    
    var product: ProductPresentable!
    
    init(with view: DetailViewProtocol, basketMemoryService: BasketMemoryService, wishlistMemoryService: WishlistMemoryService) {
        self.view = view
        self.basketMemoryService = basketMemoryService
        self.wishlistMemoryService = wishlistMemoryService
    }
    
    func addProductToWishlist() {
        wishlistMemoryService.add(product: product)
    }
    
    func addProductToBasket() {
        basketMemoryService.add(product: product)
    }
}
