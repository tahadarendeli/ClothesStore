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
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout, spacing: 20) {
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
                                    Text(productName)
                                        .font(.custom("HelveticaNeue-Light", size: 14))
                                        .lineLimit(2)
                                        .minimumScaleFactor(0.75)
                                        .foregroundColor(.init(UIColor.lightGray))
                                    
                                    Text(CurrencyHelper.getMoneyString(productPrice))
                                        .font(.custom("HelveticaNeue-Bold", size: 18))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .foregroundColor(.init(UIColor.darkGray))
                                }
                                .background(Color.white)
                                .cornerRadius(10.0)
                                .shadow(color: Color(.displayP3, red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1),
                                        radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                                        x: 0.0,
                                        y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(.displayP3, red: 1.0, green: 1.0, blue: 1.0, opacity: 0.85))
            .navigationBarTitle("Catalogue", displayMode: .large)
        }
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
