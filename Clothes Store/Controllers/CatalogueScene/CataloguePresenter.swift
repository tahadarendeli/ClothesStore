//
//  CataloguePresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Combine

protocol CataloguePresentation {
    func getProducts()
    func fetchProducts()
}

typealias CatalogueProduct = (ProductPresentable, Bool)

final class CataloguePresenter: CataloguePresentation {
    weak var view: CatalogueViewProtocol?
    
    private var observer: AnyCancellable?
    private var productMemoryService: ProductMemoryService!
    private var wishlistMemoryService: WishlistMemoryService!
    
    private var products : [CatalogueProduct] {
        return productMemoryService.get().map({ product in
                                                return (product, didWished(product))})
    }
    
    init(with view: CatalogueViewProtocol?, productMemoryService: ProductMemoryService, wishlistMemoryService: WishlistMemoryService) {
        self.view = view
        self.productMemoryService = productMemoryService
        self.wishlistMemoryService = wishlistMemoryService
        
        observer = WishlistMemoryService.shared().action.sink(receiveValue: { [weak self] _ in
            guard let self = self else { return }
            
            self.getProducts()
        })
    }
    
    private func didWished(_ product: ProductPresentable) -> Bool {
        return getWishlistedProducts().contains(where: { wished in
                                                    product.productId == wished.productId })
    }
    
    func getProducts() {
        view?.updateProductList(products: products)
    }
    
    func getWishlistedProducts() -> [ProductPresentable] {
        return wishlistMemoryService.get()
    }
    
    func fetchProducts() {
        ProductsDataService().getProducts { [weak self] result in
            
            guard let self = self, let result = result else { return }
            
            switch result {
            case .success(let products):
                self.productMemoryService.add(productList: products.products ?? [])
                self.getProducts()
            case .failure(_):
                self.view?.failedFetchProducts()
            }
        }
    }
}
