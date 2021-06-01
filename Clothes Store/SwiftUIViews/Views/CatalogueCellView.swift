//
//  CatalogueCellView.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class ObservableProduct: ObservableObject {
    @Published var product: CatalogueProduct
    
    init(product: CatalogueProduct) {
        self.product = product
    }
}

struct CatalogueCellView: View {
    @ObservedObject private var observableProduct: ObservableProduct
    var coordinator: Coordinator?
    
    init(product: CatalogueProduct, coordinator: Coordinator?) {
        observableProduct = ObservableProduct(product: product)
        self.coordinator = coordinator
    }
    
    var body: some View {
        let currentProduct = observableProduct.product.0
        let didAddedToWishlist = observableProduct.product.1
        
        if let productName = currentProduct.name,
           let productPrice = currentProduct.price,
           let productImage = currentProduct.image {
            
            ZStack {
                ZStack {
                    VStack(alignment: .leading, spacing: 4) {
                        ImageView(withURL: productImage)
                            .cornerRadius(10.0)
                            .aspectRatio(1.0, contentMode: .fill)
                            .clipped()
                        
                        VStack(alignment: .leading, spacing: -1) {
                            Text(productName)
                                .font(.light())
                                .lineLimit(2)
                                .minimumScaleFactor(0.75)
                                .foregroundColor(.init(UIColor.lightGray))
                            
                            Text(CurrencyHelper.getMoneyString(productPrice))
                                .font(.bold())
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .foregroundColor(.init(UIColor.darkGray))
                        }
                    }
                    
                    if didAddedToWishlist {
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Image(systemName: Strings.Images.wishlisted.rawValue)
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .frame(maxWidth: 22, maxHeight: 22)
                                    .foregroundColor(Color(.primaryColour))
                                Spacer()
                            }
                        }
                    }
                    
                }
                .padding([.top, .leading, .trailing], 8)
                .padding(.bottom, 6)
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(color: Color(.displayP3, red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1),
                        radius: 10,
                        x: 0.0,
                        y: 0.0)
                .padding(.top, 15)
                .onTapGesture {
                    (coordinator as? CatalogueViewCoordinator)?.showDetail(product: observableProduct.product)
                }
            }
            .padding([.top, .bottom], 17)
            .padding([.leading, .trailing], 15)
            .background(Color.clear)
        }
    }
}
