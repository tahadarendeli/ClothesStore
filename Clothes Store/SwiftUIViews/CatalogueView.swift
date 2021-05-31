//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI
import Combine

final class CatalogueViewModel: ObservableObject {
    @Published var result: Result<Products, Error>? = nil
    @Published var wishlist: [Product] = []
    private var observer: AnyCancellable?
    
    var value: Products? {
        try? result?.get()
    }
    
    func load() {
        ProductsDataService.getProducts(){ result in
            DispatchQueue.main.async {
                self.result = result
            }
        }
    }
    
    func setObserver() {
        observer = WishlistMemoryService.shared().action.sink(receiveValue: { [weak self] _ in
            self?.wishlist = WishlistMemoryService.shared().get()
        })
    }
}

struct CatalogueView: View {
    @ObservedObject var products = CatalogueViewModel()
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.backgroundColour).ignoresSafeArea()
                
                if products.value == nil {
                    VStack{
                        ProgressView()
                            .onAppear {
                                products.load()
                                products.setObserver()
                            }
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.primaryColour)))
                    }
                } else if let products = products.value?.products {
                    ScrollView {
                        LazyVGrid(columns: layout) {
                            ForEach(products) { product in
                                CatalogueCellView(product: product,
                                                  didAddToWishlist: self.products.wishlist.contains(where: { $0.productId == product.productId }))
                            }
                        }
                    }
                }
            }
            .background(Color.clear)
            .navigationBarTitle(Strings.Texts.catalogueTitle.rawValue)
        }
    }
}

#if DEBUG
struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
#endif
