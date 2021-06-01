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
    @Published var productList: [Product] = []
    @Published var wishlist: [Product] = []
    
    private var wishlistObserver: AnyCancellable?
    
    var value: [Product] {
        productList
    }
    
    func load() {
        ProductsDataService().getProducts(){ result in
            let products = try? result?.get().products
            ProductMemoryService.shared().add(productList: products ?? [])
            
            DispatchQueue.main.async {
                self.productList = ProductMemoryService.shared().get()
            }
        }
    }
    
    func setObserver() {
        wishlistObserver = WishlistMemoryService.shared().action.sink(receiveValue: { [weak self] _ in
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
        ZStack {
            Color(UIColor.backgroundColour).ignoresSafeArea()
            
            if products.value.isEmpty {
                VStack{
                    ProgressView()
                        .onAppear {
                            products.load()
                            products.setObserver()
                        }
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.primaryColour)))
                }
            } else if let products = products.value {
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

#if DEBUG
struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
#endif
