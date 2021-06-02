//
//  CatalogueViewHostingViewController.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class CatalogueViewHostingViewController: UIHostingController<CatalogueView>, Coordinating, Storyboarded {
    var coordinator: Coordinator?

    override init(rootView: CatalogueView) {
        super.init(rootView: rootView)
        self.rootView = rootView
    }
    
    required init?(coder aDecoder: NSCoder){
        let store = CatalogueStore()
        let presenter = CataloguePresenter(with: store,
                                           productMemoryService: ProductMemoryService.shared(),
                                           wishlistMemoryService: WishlistMemoryService.shared())
        super.init(coder: aDecoder, rootView: CatalogueView(store: store, presenter: presenter, coordinator: coordinator))
        
    }
}
