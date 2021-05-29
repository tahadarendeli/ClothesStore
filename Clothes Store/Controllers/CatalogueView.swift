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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
