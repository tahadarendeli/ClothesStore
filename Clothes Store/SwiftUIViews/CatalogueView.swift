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
            ZStack {
                Color(UIColor.backgroundColour).ignoresSafeArea()
                
                if products.value == nil {
                    VStack{
                        ProgressView()
                            .onAppear {
                                products.load()
                            }
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.primaryColour)))
                    }
                } else if let products = products.value?.products {
                    
                    ScrollView {
                        LazyVGrid(columns: layout, spacing: 15) {
                            ForEach(products) { product in
                                if let productName = product.name,
                                   let productPrice = product.price,
                                   let productImage = product.image {
                                    
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
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.clear)
            .navigationBarTitle("Catalouge")
        }
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
