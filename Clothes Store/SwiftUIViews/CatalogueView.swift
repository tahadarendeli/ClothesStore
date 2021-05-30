//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class CatalougeViewModel: ObservableObject {
    @Published var result: Result<Products, Error>? = nil
    
    var value: Products? {
        try? result?.get()
    }
    
    func load() {
        ProductsDataService.getProducts(){ result in
            self.result = result
        }
    }
}

struct CatalogueView: View {
    
    @ObservedObject var products = CatalougeViewModel()
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 30) {
                
                if products.value == nil {
                    ProgressView()
                        .onAppear {
                            products.load()
                        }
                } else if let products = products.value?.products {
                    
                    ForEach(products) { product in
                        if let productName = product.name,
                           let productPrice = product.price,
                           let productImage = product.image {
                            
                            VStack(alignment: .leading) {
                                ImageView(withURL: productImage)
                                    .padding(.leading, 8)
                                    .padding(.trailing, 8)
                                    .padding(.bottom, 6)
                                Text(productName)
                                    .font(.custom("HelveticaNeue-Light", size: 14))
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.75)
                                    .foregroundColor(.init(UIColor.lightGray))
                                    .padding(.leading, 8)
                                    .padding(.trailing, 8)
                                    .padding(.bottom, 15)
                                Text(CurrencyHelper.getMoneyString(productPrice))
                                    .font(.custom("HelveticaNeue-Bold", size: 18))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(.init(UIColor.darkGray))
                                    .padding(.leading, 8)
                                    .padding(.trailing, 8)
                            }
                            .frame(maxWidth: 151, minHeight: 219, maxHeight: 219)
                            .background(Color.white)
                            .cornerRadius(10.0)
                            .shadow(color: Color(.displayP3, red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1),
                                    radius: 10,
                                    x: 0.0,
                                    y: 0.0)
                        }
                    }
                }
            }
        }
        .background(Color(.displayP3, red: 242/255.0, green: 242/255.0, blue: 242/255.0, opacity: 1.0))
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
