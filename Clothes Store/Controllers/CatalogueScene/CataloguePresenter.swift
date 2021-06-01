//
//  CataloguePresenter.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

protocol CataloguePresentation {
    func getProducts()
    func fetchProducts()
}

final class CataloguePresenter: CataloguePresentation {
    weak var view: CatalogueViewProtocol?
    
    private var productMemorySerivce = ProductMemoryService.shared()
    private var products : [Product] {
        return productMemorySerivce.get()
    }
    
    init(with view: CatalogueViewProtocol) {
        self.view = view
    }
    
    func getProducts() {
        view?.updateProductList(products: products)
    }
    
    func fetchProducts() {
        ProductsDataService().getProducts { [weak self] result in
            
            guard let self = self, let result = result else { return }
            
            switch result {
            case .success(let products):
                self.productMemorySerivce.add(productList: products.products ?? [])
                self.getProducts()
            case .failure(_):
                self.view?.failedFetchProducts()
            }
        }
    }
}
