//
//  CatalogueCellView.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class ObservableProduct: ObservableObject {
    @Published var product: Product
    @Published var didAddedToWishlist: Bool
    
    init(product: Product, didAddToWishlist: Bool) {
        self.product = product
        self.didAddedToWishlist = didAddToWishlist
    }
}

struct CatalogueCellView: View {
    @ObservedObject private var observableProduct: ObservableProduct
    @State private var showingDetail = false
    
    init(product: Product, didAddToWishlist: Bool) {
        observableProduct = ObservableProduct(product: product, didAddToWishlist: didAddToWishlist)
    }
    
    var body: some View {
        
        if let productName = observableProduct.product.name,
           let productPrice = observableProduct.product.price,
           let productImage = observableProduct.product.image {
            
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
                    
                    if observableProduct.didAddedToWishlist {
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
                    showingDetail = true
                }
                .sheet(isPresented: $showingDetail) {
                    DetailViewControllerWrapper(product: observableProduct.product)
                }
            }
            .padding([.top, .bottom], 17)
            .padding([.leading, .trailing], 15)
            .background(Color.clear)
        }
    }
}
