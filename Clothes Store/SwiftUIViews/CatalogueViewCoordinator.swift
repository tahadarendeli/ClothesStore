//
//  CatalogueViewCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class CatalogueViewCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func start() {
        let store = CatalogueStore()
        let presenter = CataloguePresenter(with: store,
                                           productMemoryService: ProductMemoryService.shared(),
                                           wishlistMemoryService: WishlistMemoryService.shared())
        let catalogueView = CatalogueView(store: store, presenter: presenter, coordinator: self)
        let viewController: CatalogueViewHostingViewController = CatalogueViewHostingViewController(rootView: catalogueView)
        
        viewController.coordinator = self
        
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func showDetail(product: CatalogueProduct) {
        let coordinator = DetailContainerCoordinator(product: product.0)
        coordinator.navigationController = UINavigationController()
        coordinator.start()
        
        self.navigationController?.present(coordinator.navigationController ?? UINavigationController(), animated: true, completion: nil)
    }
}
