//
//  CatalougeView.swift
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

struct CatalougeView: View {
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
                                CatalougeCellView(product: product)
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

#if DEBUG
struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalougeView()
    }
}
#endif
