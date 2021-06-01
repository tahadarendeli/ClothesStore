//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI
import Combine

class CatalogueStore: ObservableObject {
    @Published var state: State = .loading
    
    enum State {
        case loading
        case loaded(products: [CatalogueProduct])
        case error
    }
}

extension CatalogueStore: CatalogueViewProtocol {
    func updateProductList(products: [CatalogueProduct]) {
        DispatchQueue.main.async {
            self.state = .loaded(products: products)
        }
    }
    
    func failedFetchProducts() {
        DispatchQueue.main.async {
            self.state = .error
        }
    }
}

struct CatalogueView: View {
    var presenter: CataloguePresentation
    var coordinator: Coordinator?
    @ObservedObject var store: CatalogueStore
    @State private var showAlert = true
    
    init(store: CatalogueStore, presenter: CataloguePresentation, coordinator: Coordinator?) {
        self.store = store
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.backgroundColour).ignoresSafeArea()
            
            switch store.state {
            
            case .loading:
                VStack{
                    ProgressView()
                        .onAppear(perform: presenter.fetchProducts)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.primaryColour)))
                }
                
            case .loaded(let products):
                
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(products, id: \.0.productId) { product in
                            CatalogueCellView(product: product,
                                              coordinator: coordinator)
                        }
                    }
                }
                
            case .error:
                VStack{
                    
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text(Strings.Texts.error.rawValue),
                          message: Text(Strings.Texts.alertMessage.rawValue),
                          dismissButton: .default(Text(Strings.Texts.retry.rawValue), action: {
                            self.showAlert = true
                            self.store.state = .loading
                            self.presenter.fetchProducts()
                          }))
                }
            }
        }
        .background(Color.clear)
        .navigationBarTitle(Strings.Texts.catalogueTitle.rawValue)
    }
}
