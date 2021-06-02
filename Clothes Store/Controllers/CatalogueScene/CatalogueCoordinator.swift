//
//  CatalogueCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

final class CatalogueCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func start() {
        let viewController = CatalogueViewController.instantiate(with: Strings.Identifiers.Storyboard.catalogue.rawValue)
        let presenter = CataloguePresenter(with: viewController,
                                           productMemoryService: ProductMemoryService.shared(),
                                           wishlistMemoryService: WishlistMemoryService.shared())
        viewController.presenter = presenter
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
