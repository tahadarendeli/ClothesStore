//
//  BasketPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

protocol BasketPresentation {
    func getProducts()
    func removeProductFromBasket(product: Product)
    func buy(_ products: [Product])
}

final class BasketPresenter: BasketPresentation {
    weak var view: BasketViewProtocol?
    
    private var basketMemoryService = BasketMemoryService.shared()
    private var productMemoryService = ProductMemoryService.shared()
    
    private var products : [Product] {
        return basketMemoryService.get()
    }
    
    init(with view: BasketViewProtocol) {
        self.view = view
    }
    
    func getProducts() {
        view?.updateBasket(with: products)
        calculateTotalPrice()
    }
    
    func removeProductFromBasket(product: Product) {
        basketMemoryService.remove(product: product)
        
        getProducts()
    }
    
    private func calculateTotalPrice() {
        
        var totalPrice: Float = 0.0
        
        products.forEach({
            if let price = $0.price,
               let quantity = $0.stock {
                totalPrice = totalPrice + price * Float(quantity)
            }
        })
        
        let checkoutText = CurrencyHelper.getMoneyString(totalPrice)
        view?.updateCheckoutText(with: checkoutText)
    }
    
    func buy(_ products: [Product]) {
        products.forEach({
            productMemoryService.buy(product: $0)
            removeProductFromBasket(product: $0)
        })
        
        getProducts()
    }
}

