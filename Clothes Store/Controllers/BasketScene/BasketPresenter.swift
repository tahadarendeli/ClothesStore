//
//  BasketPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

protocol BasketPresentation {
    var products : [ProductPresentable] { get }
    var heightForRow: CGFloat { get }
     
    func getProducts()
    func removeProductFromBasket(product: ProductPresentable)
    func buy()
}

final class BasketPresenter: BasketPresentation {
    weak var view: BasketViewProtocol?
    
    private var basketMemoryService: BasketMemoryService!
    private var productMemoryService: ProductMemoryService!
    
    var products : [ProductPresentable] {
        return basketMemoryService.get()
    }
    
    var heightForRow: CGFloat {
        return 125
    }
    
    init(with view: BasketViewProtocol, basketMemoryService: BasketMemoryService, productMemoryService: ProductMemoryService) {
        self.view = view
        self.basketMemoryService = basketMemoryService
        self.productMemoryService = productMemoryService
    }
    
    func getProducts() {
        view?.updateBasket()
        calculateTotalPrice()
    }
    
    func removeProductFromBasket(product: ProductPresentable) {
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
    
    func buy() {
        products.forEach({
            productMemoryService.buy(product: $0)
            removeProductFromBasket(product: $0)
        })
        
        getProducts()
    }
}

