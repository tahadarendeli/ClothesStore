//
//  DetailPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

protocol DetailPresentation {
    func addProductToWishlist(product: Product)
    func addProductToBakset(product: Product)
}

final class DetailPresenter: DetailPresentation {
    weak var view: DetailViewProtocol?
    
    private var basketMemoryService = BasketMemoryService.shared()
    private var wishlistMemoryService = WishlistMemoryService.shared()
    
    init(with view: DetailViewProtocol) {
        self.view = view
    }
    
    func addProductToWishlist(product: Product) {
        wishlistMemoryService.add(product: product)
    }
    
    func addProductToBakset(product: Product) {
        basketMemoryService.add(product: product)
    }
}
