//
//  CatalougeCellView.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class ObservableProduct: ObservableObject {
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
}

struct CatalougeCellView: View {
    @ObservedObject private var observableProduct: ObservableProduct
    @State private var showingDetail = false
    
    init(product: Product) {
        observableProduct = ObservableProduct(product: product)
    }
    
    var body: some View {
        
        if let productName = observableProduct.product.name,
           let productPrice = observableProduct.product.price,
           let productImage = observableProduct.product.image {
            VStack(alignment: .leading) {
                ImageView(withURL: productImage)
                    .cornerRadius(10.0)
                    .padding([.top, .leading, .trailing], 8)
                    .clipped()
                
                Text(productName)
                    .font(.custom("HelveticaNeue-Light", size: 14))
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.init(UIColor.lightGray))
                    .padding([.top,.leading, .trailing], 8)
                
                Text(CurrencyHelper.getMoneyString(productPrice))
                    .font(.custom("HelveticaNeue-Bold", size: 18))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.init(UIColor.darkGray))
                    .padding([.top, .leading, .trailing, .bottom], 8)
            }
            .frame(maxWidth: 151, maxHeight: 219)
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
    }
}
